import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class FotoProfil extends StatelessWidget {
  final String url_foto;
  final double width;
  final double height;

  const FotoProfil(
      {Key key,
        @required this.url_foto,
        @required this.width,
        @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.0),
      child: CachedNetworkImage(
        imageUrl: url_foto,
        height: height,
        width: width,
        placeholder: (context, url) => CircularProgressIndicator(backgroundColor: Colors.white,),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
