import 'package:flutter/material.dart';
import 'package:flutter_app_c4f_user_app/model/cards.dart';
import 'package:flutter_app_c4f_user_app/model/spcart_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_c4f_user_app/spcart/spcard_viewmodel.dart';

class ItemWidget extends StatefulWidget {
  final CardItem cardItem;
  final int position;

  ItemWidget(this.cardItem, this.position);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    var shoppingCardModel = SpCartViewModel.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 90.0,
                  width: 90.0,
                  child: Image.network(
                    widget.cardItem.productImage,
                    width: 90.0,
                    height: 90.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.cardItem.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15.0,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Giá: ${widget.cardItem.price} đ",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: <Widget>[
                      _incrementBtnWidget(shoppingCardModel, widget.position),
                      SizedBox(
                        width: 15,
                      ),
                      Text("${widget.cardItem.quantity}",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                      SizedBox(
                        width: 15,
                      ),
                      _decrementBtnWidget(shoppingCardModel, widget.position),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateMoney(SpCartViewModel model) {
    double sum = 0;
    for (int i = 0; i < model.cards.items.length; i++) {
      sum += model.cards.items[i].quantity * model.cards.items[i].price;
    }

    setState(() {
      model.cards.total = sum;
    });
  }

  Widget _incrementBtnWidget(SpCartViewModel model, int pos) {
    return SizedBox(
      width: 42,
      height: 42,
      child: RaisedButton(
        onPressed: () {
          CardItem card = model.cards.items[pos];
          model.update(card.productId, card.quantity - 1).then((value) {
            setState(() {
              model.cards.items[pos].quantity = value;
              _updateMoney(model);
            });
          });
        },
        color: Colors.white,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0)),
        child: SizedBox(
            width: 32,
            height: 32,
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ))),
      ),
    );
  }

  Widget _decrementBtnWidget(SpCartViewModel model, int pos) {
    return SizedBox(
      width: 42,
      height: 42,
      child: RaisedButton(
        onPressed: () {
          print(pos);
          CardItem card = model.cards.items[pos];
          if (card.quantity == 1) {
            return;
          }
          model.update(card.productId, card.quantity + 1).then((value) {
            setState(() {
              model.cards.items[pos].quantity = value;
              _updateMoney(model);
            });
          });
        },
        color: Colors.white,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0)),
        child: SizedBox(
            width: 32,
            height: 32,
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ))),
      ),
    );
  }
}
