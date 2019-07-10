import 'dart:async';
import 'dart:convert' as JSON;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_c4f_user_app/account/model/user.dart';
import 'package:flutter_app_c4f_user_app/cache/cache_manager.dart';
import 'package:flutter_app_c4f_user_app/model/count.dart';
import 'package:flutter_app_c4f_user_app/model/product.dart';
import 'package:flutter_app_c4f_user_app/model/rest_error.dart';
import 'package:flutter_app_c4f_user_app/network/chapi_api.dart';
import 'package:flutter_app_c4f_user_app/network/endpoint.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_c4f_user_app/network/endpoint.dart';

class HomeViewModel with ChangeNotifier {
  int _total = 0;
  String _currentOrderId;

  int get total => _total;

  set total(int value) {
    _total = value;
    notifyListeners();
  }

  set currentOrderId(value) {
    _currentOrderId = value;
  }

  get currentOrderId => _currentOrderId;

  static HomeViewModel of(BuildContext context) {
    return Provider.of<HomeViewModel>(context);
  }

  Future<List<Product>> fetchProductList() async {
    print("fetchProductList");

    var completer = Completer<List<Product>>();

    try {
      var response = await ChapiAPI.get().get(EndPoint.LIST_PRODUCT);
      print(response.data);
      ListProduct listProduct = ListProduct.fromJson(response.data);
      completer.complete(listProduct.data);
    } on DioError catch (restError) {
      completer.completeError(RestError.fromJson(restError.response.data));
    } catch (e) {
      print("ERROR ==> ${e}");
    }

    return completer.future;
  }

  Future<int> addToCard(Product product) async {
    var completer = new Completer<int>();
    try {
      var response = await ChapiAPI.get()
          .post(EndPoint.ADD_TO_CARD, data: product.toJson());

      Map json = JSON.jsonDecode(response.toString());
      completer.complete(json['data']['total']);
    } on DioError catch (e) {
      if (e.response != null) {
        completer.completeError(RestError.fromJson(e.response.data));
      } else {
        completer.completeError(e);
      }
    } catch (e) {
      print(e);
    }

    return completer.future;
  }

  /**
   *
   */
  Future<Count> countShoppingCard() async {
    var completer = new Completer<Count>();
    try {
      var response = await ChapiAPI.get().get(EndPoint.COUNT_SHOPPING_CARD);

      Count count = Count.fromJson(response.data);
      _currentOrderId = count.orderId;

      completer.complete(count);
    } on DioError catch (e) {
      if (e.response != null) {
        completer.completeError(RestError.fromJson(e.response.data));
      } else {
        completer.completeError(e);
      }
    } catch (e) {
      print(e);
    }

    return completer.future;
  }
}
