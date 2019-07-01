import 'package:dio/dio.dart';

class ChapiAPI {
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 3000;

  static Dio get() {
    BaseOptions options = new BaseOptions(
        baseUrl: "http://localhost:3000/sign-in",
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout);
    Dio dio = new Dio(options);

    dio.interceptors.add(LogInterceptor(responseBody: false));
    return dio;
  }
}
