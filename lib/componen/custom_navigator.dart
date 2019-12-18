import 'dart:ffi';

import 'package:flutter/material.dart';

class Transisi extends MaterialPageRoute{
  final typeTransisi;
  Transisi({WidgetBuilder builder,RouteSettings settings,this.typeTransisi})
      : super(builder: builder,settings :settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    Animation<Offset> custom;
    if(typeTransisi=="Bawah"){
      custom=Tween(begin: Offset(0.0, 1.0),end: Offset(0.0, 0.0)).animate(animation);
    }else if(typeTransisi=="Atas"){
      custom=Tween(begin: Offset(0.0,-1.0),end: Offset(0.0, 0.0)).animate(animation);
    }else{
      custom=Tween(begin: Offset(0.0, 1.0),end: Offset(0.0, 0.0)).animate(animation);
    }

    return SlideTransition(position: custom,child: child,);
//    return super.buildTransitions(context, animation, secondaryAnimation, child);
  }
}


class TransisiWithDuration extends PageRouteBuilder{
  Widget widget;
  int duration;
  final typeTransisi;
  TransisiWithDuration({this.widget,this.duration,this.typeTransisi}):
        super(
          transitionDuration: Duration(milliseconds: duration),
          pageBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
            return widget;
          },
          transitionsBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
            Animation<Offset> custom;
            if(typeTransisi=="Bawah"){
              custom=Tween(begin: Offset(0.0, 1.0),end: Offset(0.0, 0.0)).animate(animation);
            }else if(typeTransisi=="Atas"){
              custom=Tween(begin: Offset(0.0,-1.0),end: Offset(0.0, 0.0)).animate(animation);
            }else if(typeTransisi=="SampingKanan"){
              custom=Tween(begin: Offset(1.0,1.0),end: Offset(0.0, 0.0)).animate(animation);
            }else{
              custom=Tween(begin: Offset(0.0, 1.0),end: Offset(0.0, 0.0)).animate(animation);
            }

            return SlideTransition(position: custom,child: child,);
          }
      );
}