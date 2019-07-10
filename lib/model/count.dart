class Count {
  String orderId;
  int total;

  Count({this.orderId, this.total});

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
        orderId: json['data']['orderId'] ?? "", total: json['data']['total']);
  }
}
