import 'package:flutter/material.dart';
import '../models/picture.dart';
import '../services/picsum.dart';
import '../lists/pictures_list_item.dart';

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

  Widget _buildPictureList(
      BuildContext context, AsyncSnapshot<List<Picture>> snapshot) {
    List<Picture> values = snapshot.data;
    return ListView.builder(
        itemCount: values.length,
        itemBuilder: (context, i) {
          return PictureListItem(picture:values[i], width: widget.width);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Picsum")), body: _getPictureList());
  }
}
