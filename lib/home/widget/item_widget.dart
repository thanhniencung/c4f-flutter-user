import 'package:flutter/material.dart';
import 'package:flutter_app_c4f_user_app/home/home_viewmodel.dart';
import 'package:flutter_app_c4f_user_app/model/product.dart';

class ItemWidget extends StatelessWidget {
  final Product product;
  final double width;
  final double height;

  ItemWidget(this.product, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    var viewmodel = HomeViewModel.of(context);

    return Column(
      children: <Widget>[
        Image.network(
          product.productImage,
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          product.productName,
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 100,
          height: 35,
          child: RaisedButton(
            onPressed: () {
              viewmodel.addToCard(product).then((total) {
                viewmodel.total = total;
              });
            },
            color: Colors.orange[600],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Text(
              "Buy now",
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
