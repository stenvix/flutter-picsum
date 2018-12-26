import 'package:flutter/material.dart';
import '../animations/fade_on_show.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback onTap;
  final Color color;

  const IconWidget({Key key, @required this.icon, @required this.color, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeOnShow(
        child: GestureDetector(
            onTap: onTap, child: Icon(icon, size: 64.0, color: color)));
  }
}
