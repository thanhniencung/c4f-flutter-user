import 'dart:io';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_c4f_user_app/account/sign-up/signup_viewmodel.dart';
import 'package:flutter_app_c4f_user_app/shared/app_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Đăng ký"),
          backgroundColor: Colors.orange,
        ),
        body: ChangeNotifierProvider<SignUpViewModel>(
          builder: (_) => SignUpViewModel(),
          child: SignUpWidget(),
        ));
  }
}

class SignUpWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpStateWidget();
  }
}

class _SignUpStateWidget extends State<SignUpWidget> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SignUpViewModel model = SignUpViewModel.of(context);

    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Chọn hình đại diện",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              new SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  chooseImage(model);
                },
                child: Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                            child: new CircleAvatar(
                                child: Icon(
                                  Icons.photo_camera,
                                  color: Colors.orange,
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white),
                            width: 100.0,
                            height: 100.0,
                            padding: const EdgeInsets.all(2.0),
                            decoration: new BoxDecoration(
                                color: Colors.orange, shape: BoxShape.circle)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        model.image == null
                            ? Container()
                            : Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: new NetworkImage(model.image)))),
                      ],
                    ),
                  ],
                ),
              ),
              new SizedBox(height: 20.0),
              Form(
                key: formKey,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          return model.validateDisplayName(value);
                        },
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "Tên hiển thị",
                          icon: const Icon(Icons.tag_faces),
                          enabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: backgroundGray1)),
                          disabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: backgroundGray1)),
                        ),
                      ),
                      new SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          return model.validatePhone(value);
                        },
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Số điện thoại",
                          icon: const Icon(Icons.phone),
                          enabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: backgroundGray1)),
                          disabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: backgroundGray1)),
                        ),
                      ),
                      new SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          return model.validatePass(value);
                        },
                        obscureText: true,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          labelText: "Mật khẩu",
                          icon: const Icon(Icons.lock),
                          enabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: backgroundGray1)),
                          disabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: backgroundGray1)),
                        ),
                      ),
                      new SizedBox(
                        height: 40.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          submitForm(context, model);
                        },
                        color: Colors.orange[600],
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(7.0)),
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: Center(
                            child: Text(
                              "ĐĂNG KÝ",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  Future chooseImage(SignUpViewModel model) async {
    print("choose image");

    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return null;
    }

    int MAX_WIDTH = 500;
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file.path);
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 80,
        targetWidth: MAX_WIDTH,
        targetHeight:
            (properties.height * MAX_WIDTH / properties.width).round());

    model.uploadImage(compressedFile).then((result) {
      model.image = result.toString();
    });
  }

  void submitForm(BuildContext context, SignUpViewModel model) {
    var valid = formKey.currentState.validate();
    if (valid) {
      var loadDialog = new ProgressDialog(context, ProgressDialogType.Normal);
      loadDialog.setMessage('Đang tải...');
      loadDialog.show();

      Future.delayed(const Duration(seconds: 2), () {
        loadDialog.hide();

        model.signUp().then((result) {
          loadDialog.hide();

          print(result.data);
        }).catchError((e) {
          print(e);
          loadDialog.hide();
        });
      });
    }
  }
}
