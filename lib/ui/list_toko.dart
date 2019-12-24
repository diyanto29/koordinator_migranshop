import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class ListToko extends StatefulWidget {
  @override
  _ListTokoState createState() => _ListTokoState();
}

class _ListTokoState extends State<ListToko> {
  Widget listToko() {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 15,top: 8),
                              child: AutoSizeText(
                                "Migranshop",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    fontSize: 20, fontFamily: "MalgunBold"),
                              ),
                            )),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 15,top: 8),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: ScreenUtil.instance.setHeight(100),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.blueAccent
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(IcoFontIcons.foodCart,size: 15,color: Colors.white,),
                                    Flexible(
                                      child: AutoSizeText(
                                        "12",
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: "MalgunBold",color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            Flexible(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 4,top: 8),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: ScreenUtil.instance.setHeight(100),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.redAccent
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(IcoFontIcons.foodBasket,size: 15,color: Colors.white,),
                                    Flexible(
                                      child: AutoSizeText(
                                        "10",
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: "MalgunBold",color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            Flexible(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 4,top: 8),
                              child: Container(
                                width: ScreenUtil.mediaQueryData.size.width,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.lightGreen
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(IcoFontIcons.streetView,size: 15,color: Colors.white,),
                                    Flexible(
                                      child: AutoSizeText(
                                        "Desa  Kenanga",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: "MalgunBold",color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
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
                    child: Container(height: ScreenUtil.instance.setHeight(80),
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
                  "DAFTAR TOKO",
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
                  "Berikut daftar toko binaan\ndari koordinator",
                  style: TextStyle(fontSize: 20, letterSpacing: 0.1),
                  textScaleFactor: 0.65,
                )),
            Positioned(
                top: ScreenUtil.instance.setHeight(400),
                left: ScreenUtil.instance.setHeight(30),
                right: ScreenUtil.instance.setHeight(30),
                child: Container(
                  height: ScreenUtil.instance.setHeight(100),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        prefixIcon: Icon(
                          IcoFontIcons.search2,
                          size: 20,
                        ),
                        hintText: "Cari Toko disini...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                )),
            Positioned(
                top: ScreenUtil.instance.setHeight(500),
                left: ScreenUtil.instance.setHeight(20),
                right: ScreenUtil.instance.setHeight(20),
                bottom: ScreenUtil.instance.setHeight(5),
                child: Container(
                  height: ScreenUtil.mediaQueryData.size.height,
                  width: ScreenUtil.mediaQueryData.size.width,
                  child: listToko(),
                ))

          ],
        ),
      ),
    );
  }
}
