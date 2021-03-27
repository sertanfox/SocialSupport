import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:examples/components/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../functions.dart';

class LookingForGroup extends StatefulWidget  with Validators {
  static String routeName = "/looking_for_group";

  @override
  _LookingForGroupState createState() => _LookingForGroupState();
}

class _LookingForGroupState extends State<LookingForGroup>
    with SingleTickerProviderStateMixin {


  Validators valid = Validators();
  bool bool1 = true;
  bool bool2 = true;
  bool route = false;
  Timer _timer;
  int _start = 10;

  void routeFalse() {
    route = false;
  }

  @override
  void setState(route) {
    print("Route a girdik");
    sleep(Duration(seconds: 1));
    print("Route dan çıktık");
    Navigator.pushNamed(context, '/group_chat');
    routeFalse();
  }

  void startTimer(int time) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time == 0) {
          setState(() {
            bool1 = false;
            bool2 = false;
          });
        } else {
          time--;
        }
      },
    );
  }

  @override
  void initState() {
    startTimer(_start);
    _animationController =
        AnimationController(duration: Duration(seconds: 100), vsync: this);

    final _curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeIn);

    _animation =
        Tween<double>(begin: 0, end: 19 * math.pi).animate(_curvedAnimation)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed)
              _animationController.reverse();
            else if (status == AnimationStatus.dismissed)
              _animationController.forward();
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Animation<double> _animation;
  AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainImage(animation: _animation),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  bool1 ? valid.text11 : valid.text21,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  bool2 ? valid.text12 : valid.text22,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainImage extends AnimatedWidget {
  MainImage({
    Key key,
    @required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.rotate(angle: animation.value, child: AppLogo());
  }
}
