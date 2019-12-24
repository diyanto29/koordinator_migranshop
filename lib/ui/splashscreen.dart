import 'dart:async';

import 'package:flutter/material.dart';
import 'package:koordinator_migranshop/componen/custom_navigator.dart';
import 'package:koordinator_migranshop/session/shareprefrences.dart';
import 'package:koordinator_migranshop/ui/dashboard.dart';
import 'package:koordinator_migranshop/ui/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future<void> getSession()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    bool isLogin=prefs.getBool("isLogin");
    if(isLogin==true){
      Navigator.pushReplacement(context, TransisiWithDuration(widget: Dashboard(),duration: 300,typeTransisi: "Bawah"));
    }else{
      Navigator.pushReplacement(context, TransisiWithDuration(widget: Login(),duration: 300,typeTransisi: "Bawah"));
    }
  }
  @override
  void initState() {
    Timer(Duration(seconds: 2),(){
      getSession();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/gambar/logo_migran.png",width: 200,),
      ),
    );
  }
}
