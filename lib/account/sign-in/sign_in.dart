import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_c4f_user_app/account/sign-in/sign_in_viewmodel.dart';
import 'package:flutter_app_c4f_user_app/shared/app_style.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[300],
        body: ChangeNotifierProvider(
            builder: (context) => SignInViewModel(), child: SignInWidget()));
  }
}

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var viewmodel = SignInViewModel.of(context);

    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 120,
                height: 120,
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                child: Form(
                    key: formKey,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              return viewmodel.validatePhone(value);
                            },
                            style: AppStyle.commonFieldStyle(),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: "Phone Number",
                                icon: Icon(Icons.phone),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[200])),
                                disabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[200]))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (value) {
                              return viewmodel.validatePassword(value);
                            },
                            style: TextStyle(fontSize: 20),
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: "Password",
                                icon: Icon(Icons.lock),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[200])),
                                disabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[200]))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                              onPressed: () {
                                print("submit");
                                var isValid = formKey.currentState.validate();
                                if (isValid) {
                                  viewmodel.submit().then((user) {
                                    var loading = ProgressDialog(
                                        context, ProgressDialogType.Normal);

                                    loading.setMessage("Loading");
                                    loading.show();

                                    Future.delayed(Duration(seconds: 3), () {
                                      loading.hide();
                                      Navigator.pushNamed(context, "/sign-up");
                                    });
                                  });
                                }
                              },
                              color: Colors.orange[600],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              child: SizedBox(
                                width: 250,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/sign-up");
                },
                child: Text(
                  "Sign up now",
                  style: TextStyle(
                      fontSize: 19,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
