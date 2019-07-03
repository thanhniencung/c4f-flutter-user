import 'package:flutter/material.dart';
import 'package:flutter_app_c4f_user_app/account/sign-in/sign_in.dart';
import 'package:flutter_app_c4f_user_app/account/sign-up/sign_up.dart';
import 'package:flutter_app_c4f_user_app/home/home.dart';
import 'package:flutter_app_c4f_user_app/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashView(),
        '/sign-up': (context) => SignUpView(),
        '/sign-in': (context) => SignInView(),
        '/home': (context) => HomeView(),
      },
    );
  }
}
