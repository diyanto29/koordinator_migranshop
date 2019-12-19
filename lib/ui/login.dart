import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:koordinator_migranshop/componen/custom_navigator.dart';

import 'dashboard.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  FocusNode _focusNodeUsername = FocusNode();
  FocusNode _focusNodePassword = FocusNode();
  bool isVisibe = true;

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _focusNodeUsername.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: ScreenUtil.mediaQueryData.size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: ScreenUtil.instance.setHeight(100),
                  left: ScreenUtil.instance.setHeight(40),
                  child: Image.asset(
                    "assets/gambar/logo_migran.png",
                    width: 80,
                    height: 60,
                  )),
              Positioned(
                  top: ScreenUtil.instance.setHeight(240),
                  left: ScreenUtil.instance.setHeight(40),
                  child: AutoSizeText(
                    "Selamat Datang",
                    style: TextStyle(fontSize: 30, fontFamily: "MalgunBold"),
                  )),
              Positioned(
                  top: ScreenUtil.instance.setHeight(310),
                  left: ScreenUtil.instance.setHeight(43),
                  child: AutoSizeText(
                    "Koordinator UMKM",
                    style: TextStyle(
                        fontSize: 12, fontFamily: "malgun", letterSpacing: 2),
                  )),
              Positioned(
                top: ScreenUtil.instance.setHeight(500),
                left: ScreenUtil.instance.setHeight(50),
                right: ScreenUtil.instance.setHeight(50),
                child: Container(
                  height: ScreenUtil.instance.setHeight(300),
                  width: ScreenUtil.instance.width,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: ScreenUtil.instance.setHeight(100),
                        child: TextField(

                          focusNode: _focusNodeUsername,
                          controller: _controllerUsername,
                          onSubmitted: (submit) {
                            _focusNodeUsername.unfocus();
                            FocusScope.of(context)
                                .requestFocus(_focusNodePassword);
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "Nama Pengguna/Email",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 4)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: ScreenUtil.instance.setHeight(100),
                        child: TextField(
                          obscureText: isVisibe,
                          focusNode: _focusNodePassword,
                          textInputAction: TextInputAction.done,
                          controller: _controllerPassword,
                          decoration: InputDecoration(

                              labelText: "Kata Sandi",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 4),
                              suffixIcon: IconButton(
                                icon: isVisibe
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    isVisibe = !isVisibe;
                                  });
                                },
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: ScreenUtil.instance.setHeight(50),
                right: ScreenUtil.instance.setHeight(50),
                bottom: ScreenUtil.instance.setHeight(20),
                child: RaisedButton(
                  onPressed: () =>Navigator.pushReplacement(context, TransisiWithDuration(widget: Dashboard(),duration: 200,typeTransisi: "Bawah")),
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil.instance.setHeight(40),
                      vertical: ScreenUtil.instance.setHeight(25)),
                  child: AutoSizeText(
                    "Masuk",
                    style: TextStyle(
                        fontFamily: "MalgunBold",
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  splashColor: Colors.white,
                  color: Colors.blueAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
