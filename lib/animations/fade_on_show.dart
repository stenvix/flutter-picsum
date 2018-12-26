import 'package:flutter/material.dart';

class FadeOnShow extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeOnShow({Key key, @required this.child, this.duration})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FadeOnShowState();
}

class _FadeOnShowState extends State<FadeOnShow> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: widget.duration ?? Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget _) {
        return Opacity(
          opacity: _animation.value,
          child: widget.child,
        );
      },
    );
  }

   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
