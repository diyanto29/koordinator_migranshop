import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:koordinator_migranshop/componen/photo_profil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var img_url = "";
  var nama_lengkap = "",
      kode_koordinator = "",
      nomer_hp = "",
      jenis_kelamin = "",
      ktp = "",
      email = "",
      detail_alamat = "",
      poin = "",
      type = "",
      city_name = "",
      postal_code = "",
      province = "";

  Widget fotoProfile() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.instance.setHeight(150)),
      height: ScreenUtil.instance.setHeight(200),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topCenter,
              child: FotoProfil(
                height: ScreenUtil.instance.setHeight(160),
                width: ScreenUtil.instance.setHeight(160),
                borderRadius: 100,
                url_foto: img_url,
              )),
          Positioned(
            top: Device.screenSize.height<=640 ? Device.screenSize.height==640 ? ScreenUtil.instance.setHeight(115):ScreenUtil.instance.setHeight(115) : ScreenUtil.instance.setHeight(115),
            right: Device.screenSize.height<=640? Device.screenSize.height==640 ? ScreenUtil.instance.setHeight(295):ScreenUtil.instance.setHeight(324): ScreenUtil.instance.setHeight(240),
            bottom: Device.screenSize.height<=640 ? Device.screenSize.height==640 ?  ScreenUtil.instance.setHeight(45): ScreenUtil.instance.setHeight(45) : ScreenUtil.instance.setHeight(45),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: ScreenUtil.instance.setHeight(40),
                width: ScreenUtil.instance.setHeight(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Icon(
                    IcoFontIcons.pencil,
                    size: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("foto_koordinator").isNotEmpty) {
        img_url = prefs.getString("foto_koordinator");
      } else {
        img_url =
            "https://image.freepik.com/free-vector/gamer-mascot-geek-boy-esports-logo-avatar-with-headphones-glasses-cartoon-character_8169-228.jpg";
      }
      kode_koordinator = prefs.get("kode_koordinator");
      jenis_kelamin = prefs.get("jenis_kelamin");
      ktp = prefs.get("ktp");
      nama_lengkap = prefs.get("nama_lengkap");
      nomer_hp = prefs.get("nomer_hp");
      email = prefs.get("email");
      detail_alamat = prefs.get("detail_alamat");
      poin = prefs.get("poin");
      type = prefs.get("type");
      city_name = prefs.get("city_name");
      postal_code = prefs.get("postal_code");
      province = prefs.get("province");
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getSession();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: Container(
        height: ScreenUtil.mediaQueryData.size.height,
        width: ScreenUtil.mediaQueryData.size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: ScreenUtil.instance.setHeight(80),
                left: ScreenUtil.instance.setHeight(40),
                child: InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                )),
            fotoProfile(),
            Positioned(
                top: ScreenUtil.instance.setHeight(340),
                left: 0,
                right: 0,
                child: Center(
                  child: AutoSizeText(
                    "$nama_lengkap",
                    style: TextStyle(
                        fontFamily: "MalgunBold",
                        fontSize: 25,
                        color: Colors.black),
                  ),
                )),
            Positioned(
                top: ScreenUtil.instance.setHeight(400),
                left: 0,
                right: 0,
                child: Center(
                  child: AutoSizeText(
                    "$kode_koordinator",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                )),
            Positioned(
                top: ScreenUtil.instance.setHeight(485),
                left: 0,
                right: 0,
                child: Divider()),
            Positioned(
                top: ScreenUtil.instance.setHeight(520),
                bottom: ScreenUtil.instance.setHeight(10),
                child: Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.only(left: ScreenUtil.instance.setHeight(30)),
                  height: ScreenUtil.mediaQueryData.size.height,
                  width: ScreenUtil.mediaQueryData.size.width,
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 10),
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                height: ScreenUtil.instance.setHeight(60),
                                width: ScreenUtil.instance.setHeight(60),
                                color: Colors.amber,
                                child: Icon(
                                  IcoFontIcons.groupStudents,
                                  size: 20,
                                  color: Colors.white,
                                ))),
                        title: AutoSizeText(
                          "Jenis Kelamin",
                          style:
                          TextStyle(fontFamily: "MalgunBold", fontSize: 16),
                        ),
                        subtitle: AutoSizeText(
                          "$jenis_kelamin",
                          style:
                          TextStyle(fontFamily: "Malgun", fontSize: 15),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 10),
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                height: ScreenUtil.instance.setHeight(60),
                                width: ScreenUtil.instance.setHeight(60),
                                color: Colors.red,
                                child: Icon(
                                  IcoFontIcons.email,
                                  size: 20,
                                  color: Colors.white,
                                ))),
                        title: AutoSizeText(
                          "Email",
                          style:
                          TextStyle(fontFamily: "MalgunBold", fontSize: 16),
                        ),
                        subtitle: AutoSizeText(
                          "$email",
                          style:
                          TextStyle(fontFamily: "Malgun", fontSize: 15),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 10),
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                height: ScreenUtil.instance.setHeight(60),
                                width: ScreenUtil.instance.setHeight(60),
                                color: Colors.redAccent,
                                child: Icon(
                                  IcoFontIcons.idCard,
                                  size: 20,
                                  color: Colors.white,
                                ))),
                        title: AutoSizeText(
                          "Nomor KTP",
                          style:
                          TextStyle(fontFamily: "MalgunBold", fontSize: 16),
                        ),
                        subtitle: AutoSizeText(
                          "$ktp",
                          style:
                          TextStyle(fontFamily: "Malgun", fontSize: 15),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 10),
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                height: ScreenUtil.instance.setHeight(60),
                                width: ScreenUtil.instance.setHeight(60),
                                color: Colors.green,
                                child: Icon(
                                  IcoFontIcons.phoneCircle,
                                  size: 20,
                                  color: Colors.white,
                                ))),
                        title: AutoSizeText(
                          "Nomor Hp",
                          style:
                          TextStyle(fontFamily: "MalgunBold", fontSize: 16),
                        ),
                        subtitle: AutoSizeText(
                          "$nomer_hp",
                          style:
                          TextStyle(fontFamily: "Malgun", fontSize: 15),
                        ),
                      ),
                      InkWell(
                        hoverColor: Colors.blueAccent,
                        splashColor: Colors.blueAccent,
                        onTap: (){},
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 10),
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                  height: ScreenUtil.instance.setHeight(60),
                                  width: ScreenUtil.instance.setHeight(60),
                                  color: Colors.greenAccent,
                                  child: Icon(
                                    IcoFontIcons.streetView,
                                    size: 20,
                                    color: Colors.white,
                                  ))),
                          title: AutoSizeText(
                            "Alamat Lengkap",
                            style:
                            TextStyle(fontFamily: "MalgunBold", fontSize: 16),
                          ),
                          subtitle: AutoSizeText(
                            "$detail_alamat, $type-$city_name $postal_code, $province",
                            style:
                            TextStyle(fontFamily: "Malgun", fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: ScreenUtil.instance.setHeight(500),
                child: Container(
                  padding: EdgeInsets.only(left: ScreenUtil.instance.setHeight(50),top: ScreenUtil.instance.setHeight(30)),
                  color: Colors.grey[100],
                  width: ScreenUtil.mediaQueryData.size.width,
                  child: AutoSizeText(
                    "Profile Pengguna",
                    style: TextStyle(fontSize: 15, fontFamily: "MalgunBold"),
                  ),
                )),

          ],
        ),
      ),
    );
  }
}
