import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:koordinator_migranshop/model/model_token.dart';

class ListDataToken extends StatefulWidget {
  final String kategori;
  final String cari;

  const ListDataToken({Key key, this.kategori, this.cari}) : super(key: key);
  @override
  _ListDataTokenState createState() => _ListDataTokenState(this.kategori,this.cari);
}

class _ListDataTokenState extends State<ListDataToken> {
  final String kategori;
  final String cari;
  List<ModelToken> _listToken=[];
  List<ModelToken> _listTokenkategori=[];
  List<ModelToken> _searchResult=[];

  _ListDataTokenState(this.kategori, this.cari);


  void addList(){
    _listToken.add(new ModelToken(
        id_token: "1",
        status: "Active",
        token: "SD12CSD"
    ));
    _listToken.add(new ModelToken(
        id_token: "1",
        status: "Deactive",
        token: "QWERRTTTT"
    ));
    _listToken.add(new ModelToken(
        id_token: "1",
        status: "Active",
        token: "DFSD342"
    ));
    _listToken.add(new ModelToken(
        id_token: "1",
        status: "Active",
        token: "QWERRTTTT"
    ));
    _listToken.add(new ModelToken(
        id_token: "1",
        status: "Deactive",
        token: "ZFSD3423"
    ));


  }



  copyToClipboard(int index){
    Clipboard.setData(new ClipboardData(text: kategori!="Semua" ? _listTokenkategori[index].token : _listToken[index].token),);
    Flushbar(
      animationDuration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
      duration: Duration(seconds: 3),
      messageText: Text("Copied to Clipboard",style: TextStyle(color: Colors.white),),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      icon: Icon(
        IcoFontIcons.infoCircle,
        color: Colors.white,
      ),
      isDismissible: false,
    )..show(context);
  }

    searchToken(String cari){
    _searchResult.clear();
    if(kategori=="Semua"){
      if(cari.length<=0){
        return _listToken;
      }else{
        setState(() {
          _listToken.forEach((item){
            if(item.token.contains(cari)){
              _searchResult.add(item);
            }
          });
      print(_searchResult[0].token);
        });
      }
    }
  }


  @override
  void initState() {
    _listToken.clear();
    addList();
    _listTokenkategori.clear();
   for(int i=0;i<_listToken.length;i++){

     if(_listToken[i].status==kategori){
       setState(() {
         _listTokenkategori.add(new ModelToken(
           id_token: _listToken[i].id_token,
           token: _listToken[i].token,
           status: _listToken[i].status,
         ));
       });
     }
     print(cari);
   }
    print("kategori $kategori");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount:kategori!="Semua"  ? _listTokenkategori.length : _listToken.length,
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
                    height: 120,
                    padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(20),left: ScreenUtil.instance.setHeight(20),right: ScreenUtil.instance.setHeight(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                                child: Padding(
                                  padding:  EdgeInsets.only(top: ScreenUtil.instance.setHeight(25),right: 5,left: 15),
                                  child: AutoSizeText(
                                    kategori!="Semua"  ? _listTokenkategori[index].token : _listToken[index].token,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: "MalgunBold"),
                                  ),
                                )),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(top: ScreenUtil.instance.setHeight(20),left: 5,bottom: ScreenUtil.instance.setHeight(10),right: ScreenUtil.instance.setHeight(40)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  height: ScreenUtil.instance.setHeight(45),
                                  width: ScreenUtil.instance.setHeight(150),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kategori!="Semua" ? _listTokenkategori[index].status=="Active" ? Colors.green: Colors.red : _listToken[index].status=="Active" ? Colors.green: Colors.red),
                                  child: Center(
                                    child: AutoSizeText(
                                      kategori!="Semua"  ? _listTokenkategori[index].status : _listToken[index].status,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            InkWell(
                              onTap: (){
                                copyToClipboard(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blue
                                ),
                                margin: EdgeInsets.only(left: ScreenUtil.instance.setHeight(20),top: ScreenUtil.instance.setHeight(2)),
                                padding: EdgeInsets.all(3),
                                height: ScreenUtil.instance.setHeight(50),
                                width: ScreenUtil.instance.setHeight(240),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(IcoFontIcons.clipBoard,size: 15,color: Colors.white70,),
                                    AutoSizeText("Copy to clipboard",style: TextStyle(fontSize: 12,color: Colors.white70),)
                                  ],
                                ),
                              ),
                            )

                          ],
                        )
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
}
