import 'package:flutter/material.dart';
import 'package:we_work/screens/wrapper.dart';
import 'package:we_work/utils/colors.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double endSize = 2.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() => endSize = 1000);
      Future.delayed(Duration(milliseconds: 300), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Wrapper()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: UiColors.color2,
        alignment: Alignment.center,
        child: TweenAnimationBuilder(
          curve: Curves.ease,
          tween: Tween<double>(begin: 2, end: endSize),
          duration: Duration(milliseconds: 1500),
          builder: (context, size, child) {
            return Transform.scale(scale: size, child: child);
          },
          child: Text.rich(
            TextSpan(
              text: "we",
              style: TextStyle(fontWeight: FontWeight.w900),
              children: [
                TextSpan(
                  text: "W",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            style: TextStyle(color: Colors.white, letterSpacing: -1),
          ),
        ),
      ),
    );
  }
}