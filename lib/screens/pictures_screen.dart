import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/picture.dart';
import '../services/picsum.dart';
import '../screens/picture_screen.dart';

class PicturesScreen extends StatefulWidget {
  final double width;

  const PicturesScreen({Key key, this.width}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PicturesScreenState();
}

class _PicturesScreenState extends State<PicturesScreen> {
  Future<List<Picture>> _loadingPictures;
  @override
  void initState(){
    var service = PicsumService();
    _loadingPictures = service.getPictures();
    super.initState();
  }

  FutureBuilder<List<Picture>> _getPictureList() {    
    var futureBuilder = FutureBuilder<List<Picture>>(
      future: _loadingPictures,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            {
              return Center(child: CircularProgressIndicator());
            }
          default:
            {
              if (snapshot.hasError) {
                return new Text(snapshot.error);
              }
              return _buildPictureList(context, snapshot);
            }
        }
      },
    );

    return futureBuilder;
  }

  Widget _buildRow(Picture picture) {
    var ratio = picture.width / widget.width;
    var width = widget.width.toInt();
    var height = picture.height ~/ ratio;
    picture.imageUrl = "https://picsum.photos/$width/$height?image=${picture.id}";
    // return Container(
    //     child: GestureDetector(
    //   child: CachedNetworkImage(
    //     imageUrl: "https://picsum.photos/$width/$height?image=${picture.id}",
    //     placeholder: Center(child: CircularProgressIndicator()),
    //     errorWidget: Icon(Icons.error),
    //   ),
    //   onTap: () {
    //     print("Tapped");
    //   },
    // ));

    return ListTile(
        contentPadding: EdgeInsets.all(0),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> PictureScreen(picture: picture)));
        },
        title: Hero(tag: 'imageHero${picture.id}',
        child: CachedNetworkImage(
          imageUrl: picture.imageUrl,
          placeholder: Center(child: CircularProgressIndicator()),
          errorWidget: Icon(Icons.error, size: 64.0),
        )));
  }

  Widget _buildPictureList(
      BuildContext context, AsyncSnapshot<List<Picture>> snapshot) {
    List<Picture> values = snapshot.data;
    return ListView.builder(
        itemCount: values.length,
        itemBuilder: (context, i) {
          return _buildRow(values[i]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Picsum")), body: _getPictureList());
  }
}
