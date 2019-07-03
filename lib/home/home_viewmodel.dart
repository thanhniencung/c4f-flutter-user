import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_c4f_user_app/network/chapi_api.dart';
import 'package:flutter_app_c4f_user_app/network/endpoint.dart';
import 'package:flutter_app_c4f_user_app/account/model/user.dart';
import 'package:flutter_app_c4f_user_app/model/rest_error.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_c4f_user_app/cache/cache_manager.dart';
import 'package:flutter_app_c4f_user_app/model/product.dart';

class HomeViewModel with ChangeNotifier {
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
}
