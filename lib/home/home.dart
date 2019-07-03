import 'package:flutter/material.dart';
import 'package:flutter_app_c4f_user_app/model/rest_error.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_c4f_user_app/account/sign-in/sign_in_viewmodel.dart';
import 'package:flutter_app_c4f_user_app/home/home_viewmodel.dart';
import 'package:flutter_app_c4f_user_app/shared/app_style.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_app_c4f_user_app/cache/cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_c4f_user_app/model/product.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.orange,
        ),
        body: ChangeNotifierProvider(
            builder: (context) => HomeViewModel(), child: HomeWidget()));
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var viewmodel = HomeViewModel.of(context);

    return FutureBuilder<List<Product>>(
      future: viewmodel.fetchProductList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(snapshot.data.length, (index) {
                return Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Image.network(snapshot.data[index].productImage),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          snapshot.data[index].productName,
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ));
              }),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
