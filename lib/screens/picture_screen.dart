import 'package:flutter/material.dart';
import '../models/picture.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class PictureScreen extends StatefulWidget {
  final Picture picture;

  const PictureScreen({Key key, this.picture}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PictureScreenState();
}

class PictureScreenState extends State<PictureScreen> {

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Picture picture = widget.picture;
    return Scaffold(
        appBar: AppBar(title: Text("Picture by ${picture.author}")),
        body: Container(
            child: Column(children: <Widget>[
          Hero(
              tag: 'imageHero${picture.id}',
              child: CachedNetworkImage(imageUrl: picture.imageUrl)),
          Padding(
            child: Text(
              picture.author,
              style: TextStyle(fontSize: 24),
            ),
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColorLight,
                    child: Text("Author Page"),
                    onPressed: (){
                      print("UES");
                      _launchUrl(picture.authorUrl);
                    },
                  )
                ],
              ),
              Column(children: <Widget>[SizedBox(width: 10.0)]),
              Column(
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("Image Source"),
                    onPressed: () => _launchUrl(picture.imageUrl),
                  )
                ],
              )
            ],
          )
        ])));
  }
}
