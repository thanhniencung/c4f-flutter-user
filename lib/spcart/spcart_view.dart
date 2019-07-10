import 'package:flutter/material.dart';
import 'package:flutter_app_c4f_user_app/spcart/widget/item_widget.dart';
import 'package:flutter_app_c4f_user_app/model/cards.dart';
import 'package:flutter_app_c4f_user_app/model/spcart_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_c4f_user_app/spcart/spcard_viewmodel.dart';
import 'package:flutter_app_c4f_user_app/spcart/widget/bottom_widget.dart';

class ShoppingCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Thông tin giỏ hàng"),
        ),
        backgroundColor: Colors.orange[50],
        body: ChangeNotifierProvider<SpCartViewModel>(
          builder: (_) => SpCartViewModel(),
          child: OrderWidget(),
        ));
  }
}

class OrderWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderStateWidget();
  }
}

class _OrderStateWidget extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final SpCartInfo args = ModalRoute.of(context).settings.arguments;
    var shoppingCardModel = SpCartViewModel.of(context);
    shoppingCardModel.orderId = args.orderId;

    return Container(
      margin: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0, bottom: 30.0),
      child: FutureBuilder<Cards>(
          future: shoppingCardModel
              .getShoppingCardDetails(shoppingCardModel.orderId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: new Text(
                "${snapshot.error}",
                textAlign: TextAlign.center,
              ));
            }

            if (!snapshot.hasData) {
              return Center(child: new CircularProgressIndicator());
            }

            Cards cards = snapshot.data;
            if (cards.items.length == 0) {
              return Center(
                  child: new Text(
                "Không có dữ liệu",
                textAlign: TextAlign.center,
              ));
            }

            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: shoppingCardModel.cards.items.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, position) {
                      return ItemWidget(
                          shoppingCardModel.cards.items[position], position);
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                BottomWidget(shoppingCardModel.orderId)
              ],
            );
          }),
    );
  }
}
