import 'package:flutter/material.dart';
import 'package:flutter_app_c4f_user_app/model/cards.dart';
import 'package:flutter_app_c4f_user_app/model/spcart_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_c4f_user_app/spcart/spcard_viewmodel.dart';

class BottomWidget extends StatelessWidget {
  final String orderId;

  BottomWidget(this.orderId);

  @override
  Widget build(BuildContext context) {
    var shoppingCardModel = SpCartViewModel.of(context);

    return Container(
      child: Column(
        children: <Widget>[
          shoppingCardModel.cards == null
              ? Text("")
              : Text("Thành tiền: ${shoppingCardModel.cards.total} đ",
                  style: TextStyle(
                      fontSize: 20.0,
                      height: 1.2,
                      fontWeight: FontWeight.w600,
                      color: Colors.red)),
          SizedBox(
            height: 40.0,
          ),
          RaisedButton(
            onPressed: () {
              shoppingCardModel
                  .confirm(orderId)
                  .then((success) => Navigator.pop(context));
            },
            color: Colors.orange[600],
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(7.0)),
            child: SizedBox(
              width: 250,
              height: 50,
              child: Center(
                child: Text(
                  "Tiến hành đặt hàng",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
