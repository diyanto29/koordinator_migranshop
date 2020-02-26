import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:koordinator_migranshop/componen/server.dart';
import 'package:koordinator_migranshop/model/model_token.dart';
import 'package:koordinator_migranshop/ui/list_data_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ListToken extends StatefulWidget {
  @override
  _ListTokenState createState() => _ListTokenState();
}

class _ListTokenState extends State<ListToken>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> keyScaffold=new GlobalKey<ScaffoldState>();
  StreamController<void> cariToken = StreamController<bool>.broadcast();
  Dio dio;
  List<ModelToken> listToken=List<ModelToken>();

  final List<Tab> tabs = <Tab>[
    new Tab(text: "Semua"),
    new Tab(text: "Active"),
    new Tab(text: "Deactive"),
  ];

  Widget tabbar() {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        key: keyScaffold,
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: new Container(
            height: ScreenUtil.getInstance().setHeight(100),
            child: Center(
              child: new TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: new BubbleTabIndicator(
                  indicatorHeight: 30.0,
                  indicatorRadius: 30,
                  indicatorColor: Colors.blue,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
                tabs: tabs,
                // controller: _tabController,
              ),
            ),
          ),
        ),
        body: TabBarView(
            children: tabs.map((Tab tab) {
            if(tab.text=="Semua"){
              return ListDataToken(kategori: "Semua",);
            }else if(tab.text=="Active"){

              return ListDataToken(kategori: "Active",);
            }else if(tab.text=="Deactive"){
              return ListDataToken(kategori: "Deactive",);
            }

            else{
              return ListDataToken(kategori: "Semua",);
            }
        }).toList()),
      ),
    );
  }
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
  Future<bool> tambahToken()async{
    _onLoading();
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.get("token");
    var kode=prefs.get("kode_koordinator");
    print(token);
    String url=Server.tambah_token;
    await http.post(url,
        body: {
          "kd_kordinator" : "$kode"
        },
        headers: {
      "Authorization" : "Bearer $token"
    }).then((response){
      print(response.body);
      if(response.statusCode==200){
        Navigator.pop(context);
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.GROUNDED,
          message: "Berhasil Tambah Token",
        )..show(context);

      }
    });

    return true;
  }





  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Scaffold(
      body: Container(
        height: ScreenUtil.mediaQueryData.size.height,
        width: ScreenUtil.mediaQueryData.size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: ScreenUtil.instance.setHeight(20),
                left: ScreenUtil.instance.setHeight(-30),
                child: Container(
                  height: ScreenUtil.instance.setHeight(200),
                  width: ScreenUtil.instance.setHeight(200),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(135, 206, 250, 500),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(-30),
                          bottomRight: Radius.circular(100),
                          topRight: Radius.circular(40))),
                  child: Center(
                    child: Container(
                      height: ScreenUtil.instance.setHeight(80),
                      width: ScreenUtil.instance.setHeight(80),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border:
                              Border.all(color: Colors.blueAccent, width: 2)),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Center(
                          child: Icon(Icons.arrow_back_ios,
                              size: 15, color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  ),
                )),
            Positioned(
                top: ScreenUtil.instance.setHeight(230),
                left: ScreenUtil.instance.setHeight(60),
                child: AutoSizeText(
                  "DAFTAR TOKEN",
                  style: TextStyle(
                      fontFamily: "MalgunBold",
                      fontSize: 20,
                      letterSpacing: 0.1),
                  textScaleFactor: 1.2,
                )),
            Positioned(
                top: ScreenUtil.instance.setHeight(300),
                left: ScreenUtil.instance.setHeight(60),
                child: AutoSizeText(
                  "Berikut daftar Token\ndari koordinator",
                  style: TextStyle(fontSize: 20, letterSpacing: 0.1),
                  textScaleFactor: 0.65,
                )),
            Positioned(
                top: ScreenUtil.instance.setHeight(400),
                left: ScreenUtil.instance.setHeight(30),
                right: ScreenUtil.instance.setHeight(30),
                child: Container(
                  height: ScreenUtil.instance.setHeight(60),
                  child: RaisedButton(
                    onPressed: ()=>tambahToken(),
                    splashColor: Colors.white,
                    elevation: 3,
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(IcoFontIcons.plusCircle,size: 20,color: Colors.white,),
                        SizedBox(width: 20,),
                        AutoSizeText("Tambah Token",style: TextStyle(fontSize: 16,color: Colors.white,letterSpacing: 1),),
                      ],
                    ),
                  )
                )),
            Positioned(
                top: ScreenUtil.instance.setHeight(480),
                left: ScreenUtil.instance.setHeight(20),
                right: ScreenUtil.instance.setHeight(20),
                bottom: ScreenUtil.instance.setHeight(5),
                child: Container(
                  height: ScreenUtil.mediaQueryData.size.height,
                  width: ScreenUtil.mediaQueryData.size.width,
                  child: tabbar(),
                ))
          ],
        ),
      ),
    );
  }
}
