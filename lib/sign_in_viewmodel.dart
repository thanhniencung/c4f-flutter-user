import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SignInViewModel with ChangeNotifier {
  int count = 0;

  static SignInViewModel of(BuildContext context) {
    return Provider.of<SignInViewModel>(context);
  }

  increment() {
    count++;
    notifyListeners();
  }
}
