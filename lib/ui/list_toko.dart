import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:koordinator_migranshop/componen/list_detail_toko.dart';
import 'package:koordinator_migranshop/componen/server.dart';
import 'package:koordinator_migranshop/model/model_list_toko.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';

class ListToko extends StatefulWidget {
  @override
  _ListTokoState createState() => _ListTokoState();
}

class _ListTokoState extends State<ListToko> {
  Dio dio;
  List<ModelListToko> _listToko=[];

  GlobalKey<ScaffoldState> scaffoldKey=GlobalKey<ScaffoldState>();
  PersistentBottomSheetController _controllerBottomSheet;


  String noKtp,namaLengkap,jenisKelamin,alamatPemilik,nomorTelepon,email,noRek,namaNasabah,jenisBank,namaToko,deskripsiToko,alamatToko;
  bool isData=false;
  bool bottomSheet = false;

  getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> header = {};
    header.clear();
    header = {
      "Authorization": "Bearer " + prefs.get('token'),
      "Cache-Control": "no-cache",
      "api": "1.0.0",
    };
    return header;
  }
  

  Future<void> getDetailToko(String kd_toko)async{
    dio=new Dio(new BaseOptions(
      headers: await getHeaders()
    ));
    Response response;
    String url=Server.detail_toko+"/$kd_toko";
    response=await dio.get(url);
    if(response.data['code']==200){
      _controllerBottomSheet.setState(
          (){
            isData=!isData;
            noKtp=response.data['detail_toko']['data_detail']['ktp'];
            namaLengkap=response.data['detail_toko']['data_detail']['nama_lengkap'];
            jenisKelamin=response.data['detail_toko']['jenis_kelamin'];
            alamatPemilik=response.data['detail_toko']['data_detail']['detail_alamat']+", "+response.data['detail_toko']['data_detail']['type']+" "+response.data['detail_toko']['data_detail']['city_name']+
                " "+ response.data['detail_toko']['data_detail']['postal_code']+" Provinsi " +response.data['detail_toko']['data_detail']['province'];
            nomorTelepon=response.data['detail_toko']['data_detail']['nomer_hp'];
            email=response.data['detail_toko']['data_detail']['email'];
            noRek=response.data['detail_toko']['data_detail']['no_rekening'];
            namaNasabah=response.data['detail_toko']['data_detail']['nama_nasabah'];
            jenisBank=response.data['detail_toko']['data_detail']['nama_bank'];
            namaToko=response.data['detail_toko']['data_detail']['nama_toko'];
            deskripsiToko=response.data['detail_toko']['data_detail']['deskripsi_toko'];
            alamatToko=response.data['detail_toko']['data_detail']['alamat_toko'];
          }
      );
    }
  }

  Future<List> getListToko()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var token=prefs.get("token");
    var kode_koordinator=prefs.get("kode_koordinator");
    String url=Server.list_toko+"/$kode_koordinator";
    Response response;
    dio=new Dio(new BaseOptions(
      headers: await getHeaders()
    ));
    response=await dio.get(url);
    if(response.data['pesan']['code']==200){
      List toko=response.data['toko'];
      _listToko.clear();
      for(int i=0;i<toko.length;i++){
        setState(() {
          _listToko.add(ModelListToko(
            kdToko: toko[i]['kd_toko'],
            namaToko: toko[i]['nama_toko'],
            alamatToko: toko[i]['alamat_toko']+toko[i]['city_name']+toko[i]['province'],
            deskripsiToko: toko[i]['deskripsi_toko'],
            totalProdukToko: toko[i]['produk'],
            fotoToko: toko[i]['foto_toko']
          ));
        });
      }
    }
    


    return _listToko;


  }


  back() {
    if (bottomSheet) {
      _controllerBottomSheet.close();
      setState(() {
        bottomSheet = !bottomSheet;
        isData=!isData;
      });
    } else {
      Navigator.pop(context);
      setState(() {
        bottomSheet = !bottomSheet;
        isData=!isData;
      });
    }
  }

  Future<bool> _onWillPop() {
    return back() ?? false;
  }



  Widget _bottomSheetBuilder(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return SwipeDetector(
      onSwipeDown:  () {
        _controllerBottomSheet.close();
        setState(() {
          bottomSheet = !bottomSheet;
          isData=!isData;
        });
      },
      child: Material(
        color: Colors.white,
        elevation: 20,
        shadowColor: Colors.red,
        animationDuration: Duration(seconds: 60),
        type: MaterialType.card,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Container(
            height: ScreenUtil.instance.setHeight(1000),
            width: ScreenUtil.screenWidth,
            margin: EdgeInsets.only(bottom: ScreenUtil.instance.setHeight(40)),
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child:isData ?  ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Center(
                    child: Container(
                        width: 50,
                        child: Divider(thickness: 4,)),
                  ),
                  Padding(padding: EdgeInsets.only(left: ScreenUtil.instance.setHeight(40)),
                    child: AutoSizeText("Info Pemilik Toko",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),),
                  ListDetailToko(
                    title: "Nomor KTP",
                    content: "$noKtp",
                    icon: IcoFontIcons.user,
                    colorIcon: Colors.amber,
                  ),
                  ListDetailToko(
                    title: "Nama Lengkap",
                    content: "$namaLengkap",
                    icon: IcoFontIcons.user,
                    colorIcon: Colors.amberAccent,
                  ),
                  ListDetailToko(
                    title: "Jenis Kelamin",
                    content: "$jenisKelamin",
                    icon: IcoFontIcons.groupStudents,
                    colorIcon: Colors.blue,
                  ),
                  ListDetailToko(
                    title: "Alamat",
                    content: "$alamatPemilik",
                    icon: Icons.streetview,
                    colorIcon: Colors.blueAccent,
                  ),
                  ListDetailToko(
                    title: "Nomor Telephon",
                    content: "$nomorTelepon",
                    icon: IcoFontIcons.phoneCircle,
                    colorIcon: Colors.lightBlue,
                  ),
                  ListDetailToko(
                    title: "Email",
                    content: "$email",
                    icon: IcoFontIcons.user,
                    colorIcon: Colors.lightBlueAccent,
                  ),
                  Padding(padding: EdgeInsets.only(left: ScreenUtil.instance.setHeight(40),top: ScreenUtil.instance.setHeight(30)),
                    child: AutoSizeText("Info Rekening Toko",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),),
                  ListDetailToko(
                    title: "Nomor Rekening",
                    content: "$noRek",
                    icon: IcoFontIcons.bank,
                    colorIcon: Colors.red,
                  ),
                  ListDetailToko(
                    title: "Nama Nasabah",
                    content: "$namaNasabah",
                    icon: IcoFontIcons.card,
                    colorIcon: Colors.redAccent,
                  ),
                  ListDetailToko(
                    title: "Jenis Bank",
                    content: "$jenisBank",
                    icon: IcoFontIcons.bankTransfer,
                    colorIcon: Colors.red[800],
                  ),
                  Padding(padding: EdgeInsets.only(left: ScreenUtil.instance.setHeight(40),top: ScreenUtil.instance.setHeight(30)),
                    child: AutoSizeText("Info Detail Toko",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),),
                  ListDetailToko(
                    title: "Nama Toko",
                    content: "$namaToko",
                    icon: IcoFontIcons.stumbleupon,
                    colorIcon: Colors.green,
                  ),
                  ListDetailToko(
                    title: "Deskripsi Toko",
                    content: "$deskripsiToko",
                    icon: IcoFontIcons.pen,
                    colorIcon: Colors.greenAccent,
                  ),
                  ListDetailToko(
                    title: "Alamat Toko",
                    content: "$alamatToko",
                    icon: IcoFontIcons.streetView,
                    colorIcon: Colors.green,
                  ),
                ],
              ) : SpinKitCubeGrid(
                size: 40,
                color: Colors.blueAccent,
              ),
            )),
      ),
    );
  }

  createBottomSheet()async{
    _controllerBottomSheet=  scaffoldKey.currentState.showBottomSheet(_bottomSheetBuilder,elevation: 3,shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
    ));
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return WillPopScope(
       onWillPop: _onWillPop,
      child: Scaffold(
        key: scaffoldKey,
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
                          onPressed: () {
                            back();
                          },
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
//              Positioned(
//                  top: ScreenUtil.instance.setHeight(400),
//                  left: ScreenUtil.instance.setHeight(30),
//                  right: ScreenUtil.instance.setHeight(30),
//                  child: Container(
//                    height: ScreenUtil.instance.setHeight(100),
//                    child: TextField(
//                      keyboardType: TextInputType.emailAddress,
//                      textInputAction: TextInputAction.search,
//                      decoration: InputDecoration(
//                          contentPadding: EdgeInsets.all(10),
//                          prefixIcon: Icon(
//                            IcoFontIcons.search2,
//                            size: 20,
//                          ),
//                          hintText: "Cari Toko disini...",
//                          border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(10),
//                          )),
//                    ),
//                  )),
              Positioned(
                  top: ScreenUtil.instance.setHeight(350),
                  left: ScreenUtil.instance.setHeight(20),
                  right: ScreenUtil.instance.setHeight(20),
                  bottom: ScreenUtil.instance.setHeight(5),
                  child: Container(
                    height: ScreenUtil.mediaQueryData.size.height,
                    width: ScreenUtil.mediaQueryData.size.width,
                    child: FutureBuilder(
                        future: getListToko(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            List<ModelListToko> listToko=snapshot.data;
                            return AnimationLimiter(
                              child: ListView.builder(
                                itemCount: listToko.length,
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
                                          child: InkWell(
                                            onTap: (){
                                              getDetailToko(listToko[index].kdToko);
                                              if (!bottomSheet) {
                                                createBottomSheet();
                                                setState(() {
                                                  bottomSheet = !bottomSheet;
                                                });
                                              } else {
                                                _controllerBottomSheet.close();
                                                setState(() {
                                                  bottomSheet = !bottomSheet;
                                                  isData=!isData;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 120,
                                              width: MediaQuery.of(context).size.width,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Flexible(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 15,top: 8),
                                                        child: AutoSizeText(
                                                          "Toko "+listToko[index].namaToko,
                                                          overflow: TextOverflow.visible,
                                                          style: TextStyle(
                                                              fontSize: 20, fontFamily: "MalgunBold"),
                                                        ),
                                                      )),
                                                  Flexible(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 15,top: 8),
                                                        child: AutoSizeText(
                                                          listToko[index].deskripsiToko,
                                                          overflow: TextOverflow.visible,
                                                          style: TextStyle(
                                                              fontSize: 15, fontFamily: "Malgun"),
                                                        ),
                                                      )),
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
                                                                    child: Center(
                                                                      child: AutoSizeText(
                                                                        listToko[index].totalProdukToko,
                                                                        overflow: TextOverflow.visible,
                                                                        style: TextStyle(
                                                                            fontSize: 15, fontFamily: "MalgunBold",color: Colors.white),
                                                                      ),
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
                                                                    listToko[index].alamatToko,
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
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return Center(
                            child: SpinKitFadingCube(
                              size: 30,
                              color: Colors.blueAccent,
                            ),
                          );
                        },),
                  ))

            ],
          ),
        ),
      ),
    );
  }
}
