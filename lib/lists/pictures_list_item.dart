import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../config.dart';
import '../screens/picture_screen.dart';
import '../models/picture.dart';
import '../elements/icon.dart';

class PictureListItem extends StatefulWidget {
  final Picture picture;
  final double width;

  const PictureListItem({Key key, this.picture, this.width}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PictureListItemState();
}

class _PictureListItemState extends State<PictureListItem> {
  Picture _picture;
  bool _isSelected = false;
  bool _isFavorite = false;

  @override
  void initState() {
    _picture = widget.picture;
    super.initState();
  }

  void onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  void onFavoriteTap() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void onPictureInfoTap() {
    setState(() {
      _isSelected = false;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PictureScreen(picture: _picture)));
  }

  Widget _photoHero() {
    return Hero(
        tag: 'imageHero${_picture.id}',
        child: CachedNetworkImage(
          imageUrl: _picture.imageUrl,
          placeholder: Center(child: CircularProgressIndicator()),
          errorWidget: Icon(Icons.error, size: 64.0),
        ));
  }

  Widget _photoItem() {
    return ListTile(
        contentPadding: EdgeInsets.all(0), onTap: onTap, title: _photoHero());
  }

  Widget _selectedPhotoItem() {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      onTap: onTap,
      title: Stack(
        alignment: Alignment(0, 0),
        children: <Widget>[
          _photoHero(),
          Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconWidget(
                            onTap: onFavoriteTap,
                            color: Colors.red,
                            icon: _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border),
                        IconWidget(
                            onTap: onPictureInfoTap,
                            color: Colors.white,
                            icon: Icons.info)
                      ],
                    ),
                  )
                  // ),
                  ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var ratio = _picture.width / widget.width;
    var width = widget.width.toInt();
    var height = _picture.height ~/ ratio;
    _picture.imageUrl =
        "${Config.picsumBaseUrl}$width/$height?image=${_picture.id}";

    if (!_isSelected) {
      return _photoItem();
    }
    return _selectedPhotoItem();
  }
}
