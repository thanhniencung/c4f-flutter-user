class RestError {
  int statusCode;
  String message;

  RestError({this.statusCode, this.message});

  factory RestError.fromJson(Map<String, dynamic> json) {
    return RestError(statusCode: json['code'], message: json['message']);
  }
}
