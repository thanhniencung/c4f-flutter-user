import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sign_in_viewmodel.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (context) => SignInViewModel()),
        ],
        child: SignInWidget(),
      ),
    );
  }
}

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  @override
  Widget build(BuildContext context) {
    var viewmodel = SignInViewModel.of(context);

    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TxtCounter(),
            RaisedButton(
              onPressed: () {
                viewmodel.increment();
              },
              child: Text("Click me"),
            )
          ],
        ),
      ),
    );
  }
}

class TxtCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewmodel = SignInViewModel.of(context);

    return Text(
      "${viewmodel.count}",
      style: TextStyle(fontSize: 20),
    );
  }
}
