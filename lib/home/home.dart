import 'package:flutter/material.dart';
import 'package:flutter_app_c4f_user_app/home/home_viewmodel.dart';
import 'package:flutter_app_c4f_user_app/model/count.dart';
import 'package:flutter_app_c4f_user_app/model/product.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_c4f_user_app/home/widget/item_widget.dart';
import 'package:flutter_app_c4f_user_app/home/widget/badge_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => HomeViewModel(),
      child: Scaffold(
          backgroundColor: Colors.amber[50],
          appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.orange,
            actions: <Widget>[BadgeWidget()],
          ),
          body: HomeWidget()),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  var formKey = GlobalKey<FormState>();
  static const int NUMBER_COL = 2;

  @override
  Widget build(BuildContext context) {
    var viewmodel = HomeViewModel.of(context);

    var size = MediaQuery.of(context).size;
    var itemHeight = 220;
    var itemWidth = size.width / 2;

    return FutureBuilder<List<Product>>(
      future: viewmodel.fetchProductList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: GridView.count(
              childAspectRatio: itemWidth / itemHeight,
              crossAxisCount: NUMBER_COL,
              children: List.generate(snapshot.data.length, (index) {
                return Container(
                    padding: EdgeInsets.all(10),
                    child:
                        ItemWidget(snapshot.data[index], itemWidth - 20, 120));
              }),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
