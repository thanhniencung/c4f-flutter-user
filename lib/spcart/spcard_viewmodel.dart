import 'dart:async';
import 'dart:io';
import 'dart:convert' as JSON;
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_c4f_user_app/model/cards.dart';

import 'package:flutter_app_c4f_user_app/model/rest_error.dart';
import 'package:flutter_app_c4f_user_app/network/chapi_api.dart';
import 'package:flutter_app_c4f_user_app/network/endpoint.dart';

class SpCartViewModel extends ChangeNotifier {
  Cards _cards;
  String _orderId;

  set orderId(value) => _orderId = value;
  get orderId => _orderId;

  get cards => _cards;

  static SpCartViewModel of(BuildContext context) {
    return Provider.of<SpCartViewModel>(context);
  }

  Future<Cards> getShoppingCardDetails(String orderId) async {
    var completer = new Completer<Cards>();
    if (_cards != null) {
      completer.complete(_cards);
      return completer.future;
    }

    try {
      var response = await ChapiAPI.get().get(EndPoint.DETAIL_SHOPPING_CARD,
          queryParameters: {"order_id": orderId});

      Cards card = Cards.fromJson(response.data);
      _cards = card;
      completer.complete(card);
    } on DioError catch (e) {
      if (e.response != null) {
        completer.completeError(RestError.fromJson(e.response.data));
      } else {
        completer.completeError(e);
      }
    } catch (e) {
      print("Error getShoppingCardDetails : ${e}");
    }

    return completer.future;
  }

  Future<bool> confirm(String orderId) async {
    var completer = new Completer<bool>();
    try {
      var response = await ChapiAPI.get().post(EndPoint.CONFIRM_ORDER,
          data: {"orderId": orderId, "status": "CONFIRM"});
      completer.complete(response.statusCode == 200);
    } on DioError catch (e) {
      if (e.response != null) {
        completer.completeError(RestError.fromJson(e.response.data));
      } else {
        completer.completeError(e);
      }
    } catch (e) {
      print("Error getShoppingCardDetails : ${e}");
    }

    return completer.future;
  } //

  /**
   *
   */
  Future<int> update(String productId, int quantity) async {
    var completer = new Completer<int>();
    try {
      var response = await ChapiAPI.get().post(EndPoint.UPDATE_SHOPPING_CARD,
          data: {
            "productId": productId,
            "orderId": _orderId,
            "quantity": quantity
          });

      Map json = JSON.jsonDecode(response.toString());
      completer.complete(json['data']['quantity']);
    } on DioError catch (e) {
      if (e.response != null) {
        completer.completeError(RestError.fromJson(e.response.data));
      } else {
        completer.completeError(e);
      }
    } catch (e) {
      print("Error getShoppingCardDetails : ${e}");
    }

    return completer.future;
  }
}
