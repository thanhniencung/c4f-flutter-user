class UploadImage {
  String url;

  UploadImage({this.url});

  factory UploadImage.fromJson(Map<String, dynamic> json) {
    return UploadImage(url: json['url']);
  }
}
