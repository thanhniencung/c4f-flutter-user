import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      body: SplashWidget(),
    );
  }
}

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();

    checkAndLauch();
  }

  checkAndLauch() {
    var duration = Duration(seconds: 3);
    return Timer(duration, navigation);
  }

  navigation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get("USER") == null) {
      Navigator.of(context).pushReplacementNamed('/sign-in');
      return;
    }
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
