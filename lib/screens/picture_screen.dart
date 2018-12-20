import 'package:flutter/material.dart';
import '../models/picture.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PictureScreen extends StatefulWidget {
  final Picture picture;

  const PictureScreen({Key key, this.picture}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PictureScreenState();
}

class PictureScreenState extends State<PictureScreen> {
  
  @override
  Widget build(BuildContext context) {
    final Picture picture = widget.picture;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Picture - $picture.filename")),
      body: CachedNetworkImage(imageUrl: "https://picsum.photos/50/50?image=${picture.id}",),
    );
  }
}
