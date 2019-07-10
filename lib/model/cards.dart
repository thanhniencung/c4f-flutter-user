class Cards {
  double total;
  List<CardItem> items;

  Cards({this.total, this.items});

  factory Cards.fromJson(Map<String, dynamic> json) {
    return Cards(
        total: double.tryParse(json['data']['total'].toString()),
        items: parseData(json['data']));
  }

  static int parseTotal(json) {
    return int.tryParse(json['total']) ?? 0;
  }

  static List<CardItem> parseData(json) {
    if (json == null) return null;

    var list = json['items'] as List;
    return list.map((data) => CardItem.fromJson(data)).toList();
  }
}

class CardItem {
  String orderId;
  String productId;
  String productName;
  String productImage;
  int quantity;
  double price;

  CardItem(
      {this.orderId,
      this.productId,
      this.productName,
      this.productImage,
      this.quantity,
      this.price});

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      orderId: json['orderId'],
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      quantity: json['quantity'],
      price: double.tryParse(json['price'].toString()),
    );
  }
}
