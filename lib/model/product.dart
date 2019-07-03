class ListProduct {
  List<Product> data;

  ListProduct({this.data});

  factory ListProduct.fromJson(Map<String, dynamic> json) {
    return ListProduct(data: parseData(json));
  }

  static List<Product> parseData(json) {
    var list = json['data'] as List;
    return list.map((data) => Product.fromJson(data)).toList();
  }
}

class Product {
  String productId;
  String productName;
  String productImage;
  double price;

  Product({this.productId, this.productName, this.productImage, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        productId: json['productId'],
        productName: json['productName'],
        productImage: json['productImage'],
        price: double.tryParse(json['price'].toString()) ?? 0);
  }
}
