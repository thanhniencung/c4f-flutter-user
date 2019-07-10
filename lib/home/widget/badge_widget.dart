import 'package:flutter/material.dart';
import 'package:flutter_app_c4f_user_app/home/home_viewmodel.dart';
import 'package:flutter_app_c4f_user_app/model/count.dart';
import 'package:flutter_app_c4f_user_app/model/product.dart';
import 'package:flutter_app_c4f_user_app/model/spcart_info.dart';

class BadgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewmodel = HomeViewModel.of(context);

    return FutureBuilder<Count>(
        future: viewmodel.countShoppingCard(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Count count = snapshot.data;

            return Stack(
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      SpCartInfo data = SpCartInfo(viewmodel.currentOrderId);
                      Navigator.of(context)
                          .pushNamed('/shopping-cart', arguments: data);
                    }),
                Positioned(
                  right: 10,
                  top: 10,
                  child: new Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: Text(
                        '${count.total ?? 0}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Container();
        });
  }
}
