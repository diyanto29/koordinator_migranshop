import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:koordinator_migranshop/componen/custom_navigator.dart';
import 'package:koordinator_migranshop/componen/server.dart';
import 'package:koordinator_migranshop/session/shareprefrences.dart';

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
  SharedPrefrences _prefs = new SharedPrefrences();
  bool isVisibe = true;
  Dio _dio = Dio();

  final formKey = GlobalKey<FormState>();

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              height: 50,
              width: 50,
              child: SpinKitFadingCube(
                size: 50,
                color: Colors.blueAccent,
              ),
            ));
      },
    );
  }

  Future<bool> login() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        _onLoading();
        Response response;
        String url = Server.login;
        print(_controllerPassword.text);
        response = await _dio.post(url, data: {
          "email": "${_controllerUsername.text}",
          "password": "${_controllerPassword.text}"
        });
        if (response.data['code'] == 200) {
          Navigator.pop(context);
          var message = response.data['message'];
          _prefs.savePrefrences("isLogin", true);
          _prefs.savePrefrences("token", response.data['token_jwt']);
          _prefs.savePrefrences("kode_koordinator",
              response.data['kordinator'][0]['kode_kordinator']);
          _prefs.savePrefrences(
              "ktp", response.data['kordinator'][0]['data']['KTP']);
          _prefs.savePrefrences(
              "jenis_kelamin", response.data['kordinator'][0]['kelamin']);
          _prefs.savePrefrences(
              "email", response.data['kordinator'][0]['data']['email']);
          _prefs.savePrefrences(
              "type", response.data['kordinator'][0]['data']['type']);
          _prefs.savePrefrences(
              "city_name", response.data['kordinator'][0]['data']['city_name']);
          _prefs.savePrefrences("postal_code",
              response.data['kordinator'][0]['data']['postal_code']);
          _prefs.savePrefrences(
              "province", response.data['kordinator'][0]['data']['province']);
          _prefs.savePrefrences(
              "poin", response.data['kordinator'][0]['data']['poin']);
          _prefs.savePrefrences("detail_alamat",
              response.data['kordinator'][0]['data']['detail_alamat']);
          _prefs.savePrefrences("foto_koordinator",
              response.data['kordinator'][0]['data']['foto_koordinator']);
          _prefs.savePrefrences("nama_lengkap",
              response.data['kordinator'][0]['data']['nama_lengkap']);
          _prefs.savePrefrences(
              "nomer_hp", response.data['kordinator'][0]['data']['nomer_hp']);


          Navigator.pushReplacement(
              context,
              TransisiWithDuration(
                  widget: Dashboard(), duration: 150, typeTransisi: "Bawah"));

        } else {
          Navigator.pop(context);
          Flushbar(
            animationDuration: Duration(seconds: 1),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            messageText: Text(response.data['error']['message'],style: TextStyle(color: Colors.white,fontFamily: "MalgunBold"),),
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.FLOATING,
            icon: Icon(
              IcoFontIcons.warningAlt,
              color: Colors.white,
            ),
            isDismissible: false,
          )..show(context);
          setState(() {
            _controllerUsername.text = "";
            _controllerPassword.text = "";
            FocusScope.of(context).requestFocus(_focusNodeUsername);
          });
        }
      } catch (e) {
        Navigator.pop(context);
        Flushbar(
          animationDuration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          messageText: Text(
            "Ada masalah pada jaringan!",
            style: TextStyle(color: Colors.white),
          ),
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.GROUNDED,
          icon: Icon(
            IcoFontIcons.warningAlt,
            color: Colors.white,
          ),
          isDismissible: false,
        )..show(context);
        print(e);
      }
    }
    return true;
  }

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
                  height: ScreenUtil.instance.setHeight(500),
                  width: ScreenUtil.instance.width,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            focusNode: _focusNodeUsername,
                            controller: _controllerUsername,
                            validator: (value) => value.isEmpty
                                ? 'Nama Pengguna/Email harus diisi'
                                : null,
                            onFieldSubmitted: (submit) {
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
                          height: ScreenUtil.instance.setHeight(150),
                          child: TextFormField(
                            obscureText: isVisibe,
                            validator: (value) => value.isEmpty
                                ? 'Password harus diisi...'
                                : null,
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
              ),
              Positioned(
                left: ScreenUtil.instance.setHeight(50),
                right: ScreenUtil.instance.setHeight(50),
                bottom: ScreenUtil.instance.setHeight(20),
                child: RaisedButton(
                  onPressed: () => login(),
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
