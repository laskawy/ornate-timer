library ornate_timer;

import 'package:flutter/material.dart';

/// Ornate Timer.
class OrnateTimer extends StatefulWidget {
  final Color color;
  final int seconds;

  const OrnateTimer({Key key, this.color, this.seconds}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrnateTimerState(color, seconds);
}

class _OrnateTimerState extends State<OrnateTimer>
    with TickerProviderStateMixin {
  final Color color;
  final int seconds;
  AnimationController _controller;
  Animation<double> _animation;
  bool animationEnding = false;
  Tween _tween;

  _OrnateTimerState(this.color, this.seconds);

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: seconds));

    _tween = new Tween<double>(begin: 0, end: 307);

    _animation = _tween.animate(_controller);

    _animation.addListener(() {
      setState(() {
        if (_animation.value >= 305) {
          animationEnding = true;
        }
      });
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 311,
      height: 30,
      decoration: new BoxDecoration(
        color: Color(0xffffffff),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Color(0x42274596),
              offset: Offset(0, 13),
              blurRadius: 17,
              spreadRadius: -11)
        ],
      ),
      child: Row(
        children: <Widget>[
          Stack(children: <Widget>[
            dividerWithPadding(50),
            dividerWithPadding(100),
            dividerWithPadding(150),
            dividerWithPadding(200),
            dividerWithPadding(250),
            Container(
                width: _animation.value,
                height: 30,
                decoration: new BoxDecoration(
                    borderRadius: !animationEnding
                        ? BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          )
                        : BorderRadius.all(Radius.circular(15)),
                    color: color)),
          ])
        ],
      ),
    );
  }

  void resetTimer() {
    _controller.reset();
  }

  Widget divider() {
    return Container(
        width: 1,
        height: 27,
        decoration:
            new BoxDecoration(border: Border.all(color: color, width: 2)));
  }

  Widget dividerWithPadding(double padding) {
    return Padding(
      padding: EdgeInsets.only(left: padding),
      child: divider(),
    );
  }
}
