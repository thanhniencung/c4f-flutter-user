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

class SignInViewModel with ChangeNotifier {
  String _phone;
  String _password;

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  static SignInViewModel of(BuildContext context) {
    return Provider.of<SignInViewModel>(context);
  }

  String validatePhone(String phone) {
    if (phone.isEmpty) {
      return "Thông tin bắt buộc";
    }

    if (phone.length != 10) {
      return "Số điện thoại có 10 số";
    }

    Pattern pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(phone)) {
      return "Không hợp lệ";
    }

    _phone = phone;
    return null;
  }

  String validatePassword(String password) {
    if (password.isEmpty) {
      return "Thông tin bắt buộc";
    }

    if (password.length < 6) {
      return "Yêu cầu lớn hơn 6 ký tự";
    }

    _password = password;
    return null;
  }

  /*
  * SignInViewModel.submit(phone, pass).then((result) {})
  * */
  Future<User> submit() async {
    var completer = Completer<User>();
    try {
      Response response = await ChapiAPI.get().post(EndPoint.SIGN_IN,
          data: {"phone": _phone, "password": _password});

      User user = User.fromJson(response.data);

      // caching user info
      var preferences = await SharedPreferences.getInstance();
      preferences.setString("TOKEN", user.data.token);

      preferences.setString("USER", user.data.toJson().toString());

      completer.complete(user);
    } on DioError catch (e) {
      RestError error = RestError.fromJson(e.response.data);
      completer.completeError(error);
    }

    return completer.future;
  }
}
