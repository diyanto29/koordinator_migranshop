import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:koordinator_migranshop/componen/custom_navigator.dart';
import 'package:koordinator_migranshop/componen/photo_profil.dart';
import 'package:koordinator_migranshop/componen/server.dart';
import 'package:koordinator_migranshop/ui/list_token.dart';
import 'package:koordinator_migranshop/ui/list_toko.dart';
import 'package:koordinator_migranshop/ui/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var nama="";
  int totalToken=0;
  int totalTokoBinaan=0;

  String url_profil =
      "https://image.freepik.com/free-vector/gamer-mascot-geek-boy-esports-logo-avatar-with-headphones-glasses-cartoon-character_8169-228.jpg";

  int poin=0;

  getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = {};
    header.clear();
    header = {
      "Authorization": "Bearer " + prefs.get('token'),
      "api": "1.0.0",
    };
    return header;
  }

  Future<int> getTotalToken()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var kode_koordinator=prefs.get("kode_koordinator");
    Response response;
    String url=Server.total_token+"/$kode_koordinator";
    Dio dio=new Dio(new BaseOptions(
      headers: await getHeaders()
    ));
    response=await dio.get(url);
    setState(() {
      totalToken=response.data['total_token'];
    });
    return totalToken;
  }
  Future<int> getTotalTokobinaan()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var kode_koordinator=prefs.get("kode_koordinator");
    Response response;
    String url=Server.total_toko_binaan+"/$kode_koordinator";
    Dio dio=new Dio(new BaseOptions(
        headers: await getHeaders()
    ));
    response=await dio.get(url);
    if(response.data['pesan']['code']==200){
      setState(() {
        totalTokoBinaan=response.data['total_tokobinaan'];
      });
    }
    print(totalTokoBinaan);
    return totalTokoBinaan;
  }

  void logout() async {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        tittle: 'Logout',
        desc: 'Apakah Anda Yakin ingin Keluar ?',
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          SharedPreferences prefs=await SharedPreferences.getInstance();
          prefs.setBool("isLogin", false);
          Navigator.pushReplacement(
              context,
              TransisiWithDuration(
                  widget: Login(), duration: 150, typeTransisi: "Atas"));
        }).show();
  }

  void showSnackBar()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    Flushbar(
      animationDuration: Duration(seconds: 1),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
      messageText: Text("Selamat Datang, "+  prefs.getString("nama_lengkap"),style: TextStyle(color: Colors.white,fontFamily: "MalgunBold"),),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: Icon(
        IcoFontIcons.warningAlt,
        color: Colors.white,
      ),
      isDismissible: false,
    )..show(context);
  }

  void getSesion()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      nama=prefs.getString("nama_lengkap");
      if(prefs.getString("foto_koordinator").isNotEmpty){
        url_profil=prefs.getString("foto_koordinator");
      }
      poin=int.parse(prefs.get("poin"));
    });
  }
  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      showSnackBar();
      getSesion();
      getTotalTokobinaan();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
//          Positioned(
//              top: ScreenUtil.instance.setHeight(0),
//              right: 0,
//              child: Container(
//                height: ScreenUtil.instance.setHeight(250),
//                width: ScreenUtil.instance.setHeight(250),
//                decoration: BoxDecoration(
//                    color: Color.fromRGBO(135, 206, 250, 500),
//                    borderRadius: BorderRadius.only(
//                        bottomLeft: Radius.circular(100),
//                        bottomRight: Radius.circular(-30),
//                        topLeft: Radius.circular(40))),
//                child: Center(
//                  child: Container(
//                    alignment: Alignment.center,
//                    height: ScreenUtil.instance.setHeight(100),
//                    width: ScreenUtil.instance.setHeight(100),
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(40),
//                        border: Border.all(color: Colors.blueAccent, width: 2)),
////                    child: IconButton(
////                      onPressed: () {},
////                      icon: Center(
////                        child: Icon(Icons.notifications_active,
////                            size: 20, color: Colors.blueAccent),
////                      ),
////                    ),
//                  child: Container(),
//                  ),
//                ),
//              )),
          Positioned(
              top: ScreenUtil.instance.setHeight(200),
              left: ScreenUtil.instance.setHeight(50),
              child: FotoProfil(
                url_foto: url_profil,
                width: 60,
                height: 60,
                borderRadius: 60,
              )),
          Positioned(
            top: ScreenUtil.instance.setHeight(220),
            left: ScreenUtil.instance.setHeight(200),
            child: AutoSizeText(
              "$nama",
              style: TextStyle(
                  fontFamily: "MalgunBold", fontSize: 16, letterSpacing: 0.4),
              textScaleFactor: 1.2,
            ),
          ),
          Positioned(
            top: ScreenUtil.instance.setHeight(270),
            left: ScreenUtil.instance.setHeight(200),
            child: AutoSizeText(
              "Koordinator",
              style: TextStyle(
                  fontSize: 12, letterSpacing: 0.4),
              textScaleFactor: 1,
            ),
          ),
          Positioned(
              top: ScreenUtil.instance.setHeight(360),
              left: ScreenUtil.instance.setHeight(-10),
              right: ScreenUtil.instance.setHeight(-10),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Container(
                  height: ScreenUtil.instance.setHeight(400),
                  padding: EdgeInsets.only(
                      bottom: ScreenUtil.instance.setHeight(185),
                      left: ScreenUtil.instance.setHeight(60),
                      right: ScreenUtil.instance.setHeight(60),
                      top: ScreenUtil.instance.setHeight(20)),
                  width: ScreenUtil.mediaQueryData.size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Card(
                          margin: EdgeInsets.all(10),
                          elevation: 0.5,
                          color: Colors.blue[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
//                            border: Border.all(color: Colors.blue[300],width: 2,style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(10)),
                              height: ScreenUtil.instance.setHeight(200),
                              width: ScreenUtil.instance.setHeight(150),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                      child: AutoSizeText(
                                    "$poin",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "MalgunBold",
                                        color: Colors.white),
                                  )),
                                  Flexible(
                                      child: AutoSizeText(
                                    "Point",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Malgun",
                                        color: Colors.white),
                                  ))
                                ],
                              )),
                        ),
                      ),
                      Flexible(
                        child: Card(
                          margin: EdgeInsets.all(10),
                          elevation: 0.5,
                          color: Colors.blue[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
//                            border: Border.all(color: Colors.blue[300],width: 2,style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(10)),
                              height: ScreenUtil.instance.setHeight(200),
                              width: ScreenUtil.instance.setHeight(150),
                              child: FutureBuilder(
                                future: getTotalToken(),
                                builder: ((context,snapshot){

                                  if(snapshot.hasData){
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                            child: AutoSizeText(
                                              snapshot.data.toString(),
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontFamily: "MalgunBold",
                                                  color: Colors.white),
                                            )),
                                        Flexible(
                                            child: AutoSizeText(
                                              "Token",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Malgun",
                                                  color: Colors.white),
                                            ))
                                      ],
                                    );
                                  }
                                  return Center(
                                    child: SpinKitCircle(
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  );
                                }),
                              )),
                        ),
                      ),
                      Flexible(
                        child: Card(
                          margin: EdgeInsets.all(10),
                          elevation: 0.5,
                          color: Colors.blue[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
//                            border: Border.all(color: Colors.blue[300],width: 2,style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(10)),
                              height: ScreenUtil.instance.setHeight(200),
                              width: ScreenUtil.instance.setHeight(150),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                      child: AutoSizeText(
                                        totalTokoBinaan.toString(),
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: "MalgunBold",
                                            color: Colors.white),
                                      )),
                                  Flexible(
                                      child: AutoSizeText(
                                        "Toko Binaan  ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Malgun",
                                            color: Colors.white),
                                      ))
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              top: ScreenUtil.instance.setHeight(580),
              left: ScreenUtil.instance.setHeight(-10),
              right: ScreenUtil.instance.setHeight(-10),
              bottom: ScreenUtil.instance.setHeight(-10),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: ScreenUtil.instance.setHeight(10),
                      left: ScreenUtil.instance.setHeight(30),
                      right: ScreenUtil.instance.setHeight(30),
                      top: ScreenUtil.instance.setHeight(0)),
                  width: ScreenUtil.mediaQueryData.size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: <Widget>[
                      InkWell(
                        onTap:()=>Navigator.push(context, TransisiWithDuration(widget: ListToko(),duration: 300,typeTransisi: "Bawah")),
                        child: Container(
                          margin:
                              EdgeInsets.all(ScreenUtil.instance.setHeight(20)),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey[200], width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/gambar/ic_store.png",
                                width: 80,
                              ),
                              SizedBox(height: 10,),
                              Flexible(
                                child: AutoSizeText(
                                  "Data Toko Binaan",
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "MalgunBold"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()=>Navigator.push(context, TransisiWithDuration(widget: ListToken(),duration: 300,typeTransisi: "Bawah")),
                        child: Container(
                          margin:
                              EdgeInsets.all(ScreenUtil.instance.setHeight(20)),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey[200], width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/gambar/ic_token.png",
                                width: 80,
                              ),
                              SizedBox(height: 10,),
                              Flexible(
                                child: AutoSizeText(
                                  "Data Token",
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "MalgunBold"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()=>Navigator.push(context, TransisiWithDuration(widget: Profile(),duration: 300,typeTransisi: "Bawah")),
                        child: Container(
                          margin:
                              EdgeInsets.all(ScreenUtil.instance.setHeight(20)),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey[200], width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/gambar/ic_user_profile.png",
                                width: 80,
                              ),
                              SizedBox(height: 10,),
                              Flexible(
                                child: AutoSizeText(
                                  "Profil Pengguna",
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "MalgunBold"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.all(ScreenUtil.instance.setHeight(20)),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[200], width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          onTap: logout,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/gambar/ic_logout.png",
                                width: 80,
                              ),
                              SizedBox(height: 10,),
                              Flexible(
                                child: AutoSizeText(
                                  "Keluar",
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "MalgunBold"),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
