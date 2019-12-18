import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:koordinator_migranshop/componen/custom_navigator.dart';
import 'package:koordinator_migranshop/componen/photo_profil.dart';

import 'login.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  void logout() async {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        tittle: 'Logout',
        desc: 'Apakah Anda Yakin ingin Keluar ?',
        btnCancelOnPress: () {},
        btnOkOnPress: () async {


          Navigator.pushReplacement(
              context, TransisiWithDuration(widget: Login(),duration: 150,typeTransisi: "Atas"));
        }).show();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              child: Container(
                padding:
                    EdgeInsets.only(top: ScreenUtil.instance.setHeight(50)),
                height: ScreenUtil.instance.setHeight(400),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: ScreenUtil.instance.setHeight(50),
                        right: ScreenUtil.instance.setHeight(40),
                        child: FotoProfil(
                          width: ScreenUtil.instance.setHeight(100),
                          height: ScreenUtil.instance.setHeight(100),
                          url_foto:
                              "https://image.freepik.com/free-vector/gamer-mascot-geek-boy-esports-logo-avatar-with-headphones-glasses-cartoon-character_8169-228.jpg",
                        )),
                    Positioned(
                        top: ScreenUtil.instance.setHeight(60),
                        left: ScreenUtil.instance.setHeight(30),
                        child: AutoSizeText(
                          "Diyanto",
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "MalgubBold"),
                        )),
                    Positioned(
                        top: ScreenUtil.instance.setHeight(120),
                        left: ScreenUtil.instance.setHeight(35),
                        child: AutoSizeText(
                          "Koordinator",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "malgun"),
                        )),
                  ],
                ),
              )),
          Positioned(
              top: ScreenUtil.instance.setHeight(240),
              left: ScreenUtil.instance.setHeight(35),
              right: ScreenUtil.instance.setHeight(35),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: ScreenUtil.instance.setHeight(250),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: AutoSizeText(
                            "Total Point",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontFamily: "Malgun", fontSize: 12),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Center(
                              child: AutoSizeText(
                            "10000",
                            textScaleFactor: 3,
                            style: TextStyle(
                                letterSpacing: 5,
                                fontFamily: "MalgunBold",
                                fontSize: 30),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
            top: ScreenUtil.instance.setHeight(490),
            left: 0,
            right: 0,
            bottom: ScreenUtil.instance.setHeight(0),
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil.instance.setHeight(10)),
              height: ScreenUtil.instance.setHeight(400),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil.instance.setHeight(30),
                        right: ScreenUtil.instance.setHeight(10)),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left:15.0,top: 20),
                              child: Icon(
                                IcoFontIcons.bankAlt,
                                size: 30,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                "29",
                                textScaleFactor: 4,
                                style: TextStyle(
                                    fontSize: 50, fontFamily: "MalgunBold"),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: AutoSizeText(
                                  "Total Toko",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "MalgunBold",color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil.instance.setHeight(30),
                        right: ScreenUtil.instance.setHeight(10)),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left:15.0,top: 20),
                              child: Icon(
                                IcoFontIcons.uiLock,
                                size: 30,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                "100",
                                textScaleFactor: 4,
                                style: TextStyle(
                                    fontSize: 50, fontFamily: "MalgunBold"),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: AutoSizeText(
                                  "Total Token",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "MalgunBold",color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil.instance.setHeight(30),
                        right: ScreenUtil.instance.setHeight(10),
                    top: ScreenUtil.instance.setHeight(20)),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left:15.0,top: 20),
                              child: Icon(
                                IcoFontIcons.users,
                                size: 30,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                "100",
                                textScaleFactor: 4,
                                style: TextStyle(
                                    fontSize: 50, fontFamily: "MalgunBold"),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: AutoSizeText(
                                  "Total Users",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "MalgunBold",color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil.instance.setHeight(30),
                        right: ScreenUtil.instance.setHeight(10),
                    top: ScreenUtil.instance.setHeight(20)),
                    child: InkWell(
                      onTap: logout,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left:15.0,top: 20),
                                child: Icon(
                                  IcoFontIcons.gears,
                                  size: 30,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.exit_to_app,size: 40,),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: AutoSizeText(
                                    "Logout",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: "MalgunBold",color: Colors.blueAccent),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
