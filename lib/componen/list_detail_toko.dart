import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class ListDetailToko extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color colorIcon;

  const ListDetailToko({Key key, this.title, this.content, this.icon, this.colorIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      contentPadding: EdgeInsets.only(left: 20),
      dense: true,
      enabled: true,
      leading: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
              height: ScreenUtil.instance.setHeight(60),
              width: ScreenUtil.instance.setHeight(60),
              color: colorIcon,
              child: Icon(
                icon,
                size: 20,
                color: Colors.white,
              ))),
      title: AutoSizeText(
        "$title",
        style:
        TextStyle(fontFamily: "MalgunBold", fontSize: 16),
      ),
      subtitle: AutoSizeText(
        "$content",
        style:
        TextStyle(fontFamily: "Malgun", fontSize: 15),
      ),
    );
  }
}
