import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapiAPI {
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 3000;

  static Dio get() {
    BaseOptions options = new BaseOptions(
        baseUrl: "http://localhost:3001/product/list",
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout);
    Dio dio = new Dio(options);

    //dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options myOption) async {
      var preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("TOKEN");

      print("TOKEN = $token");

      if (token != null) {
        myOption.headers["Authorization"] = "Bearer " + token;
      }

      return myOption;
    }));
    return dio;

    // man hinh 1 : api1 => header.add(token)
    // man hinh 2 : api2 => header.add(token)
  }
}
