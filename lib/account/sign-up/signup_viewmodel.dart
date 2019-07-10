import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_c4f_user_app/account/model/upload_image.dart';
import 'package:flutter_app_c4f_user_app/account/model/user.dart';
import 'package:flutter_app_c4f_user_app/network/chapi_api.dart';
import 'package:flutter_app_c4f_user_app/network/endpoint.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class SignUpViewModel extends ChangeNotifier {
  String _image;
  String _displayName;
  String _phone;
  String _pass;

  bool _hasErrorPhoneValidation;
  bool _hasErrorPassValidation;
  bool _hasErrorDisplayValidation;

  String get image => _image;

  set image(String value) {
    _image = value;
    notifyListeners();
  }

  String get displayName => _displayName;

  set displayName(String value) {
    _displayName = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get pass => _pass;

  set pass(String value) {
    _pass = value;
  }

  static SignUpViewModel of(BuildContext context) {
    return Provider.of<SignUpViewModel>(context);
  }

  String validatePhone(String phone) {
    _hasErrorPassValidation = false;
    if (phone.isEmpty) {
      _hasErrorPassValidation = true;
      return "Thông tin bắt buộc";
    }

    if (phone.length != 10) {
      _hasErrorPassValidation = true;
      return "Số điện thoại có 10 số";
    }

    Pattern pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(phone)) return "Không hợp lệ";

    _phone = phone;

    return null;
  }

  String validateDisplayName(String displayName) {
    _hasErrorDisplayValidation = false;
    if (displayName.isEmpty) {
      _hasErrorDisplayValidation = true;
      return "Thông tin bắt buộc";
    }

    if (displayName.length < 6) {
      _hasErrorDisplayValidation = true;
      return "Yêu cầu lớn hơn 6 ký tự";
    }

    _displayName = displayName;

    return null;
  }

  String validatePass(String pass) {
    _hasErrorPhoneValidation = false;
    if (pass.isEmpty) {
      _hasErrorPhoneValidation = true;
      return "Thông tin bắt buộc";
    }

    if (pass.length < 6) {
      _hasErrorPhoneValidation = true;
      return "Yêu cầu lớn hơn 6 ký tự";
    }

    _pass = pass;

    return null;
  }

  Future<String> uploadImage(File file) async {
    var completer = new Completer<String>();
    try {
      FormData formData = new FormData.from({
        "file": new UploadFileInfo(file, basename(file.path)),
      });

      var response = await ChapiAPI.get().post(EndPoint.UPLOAD, data: formData);

      UploadImage image = UploadImage.fromJson(response.data);
      this.image = image.url;

      completer.complete(image.url);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<User> signUp() async {
    var completer = new Completer<User>();

    if (_image == null) {
      print("check image");
      completer.completeError(new Exception("Bạn chưa chọn hình ảnh"));
    }

    if (!_hasErrorPassValidation &&
        !_hasErrorPhoneValidation &&
        !_hasErrorDisplayValidation) {
      try {
        Response response = await ChapiAPI.get().post(EndPoint.SIGN_UP, data: {
          "displayName": _displayName,
          "avatar": _image,
          "phone": _phone,
          "password": _pass,
        });

        User user = new User.fromJson(response.data);
        completer.complete(user);
      } catch (e) {
        completer.completeError(e);
      }
    }
    return completer.future;
  }
}
