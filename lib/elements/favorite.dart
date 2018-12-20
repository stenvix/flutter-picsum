import 'package:flutter/material.dart';

class IconWidget extends StatefulWidget {
  final bool isFavorite;
  final GestureTapCallback onTap;

  const IconWidget({Key key, this.isFavorite, @required this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> with TickerProviderStateMixin {
  bool _isFavorite;

  Animation _animation;
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget child) {
          return Opacity(
              opacity: _animation.value,
              child: GestureDetector(
                  onTap: widget.onTap,
                  child: Icon(
                      widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 64.0,
                      color: Colors.red)));
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
