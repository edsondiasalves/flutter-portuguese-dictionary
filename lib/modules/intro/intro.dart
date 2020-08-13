import 'package:flutter/material.dart';

import '../../routes.dart';

class Intro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IntroState();
  }
}

class IntroState extends State<Intro> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, Routes.multitab);
    });
  }

  @override
  Widget build(BuildContext context) {
    final kBaseTextStyle = TextStyle(fontSize: 24);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.yellow,
              Colors.green,
              Colors.red,
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Text(
                'Português do Brasil',
                style: kBaseTextStyle,
              ),
            ),
            Image(
              image: AssetImage('assets/images/br_flag.png'),
            ),
            Center(
              child: Text(
                'Vs',
                style: kBaseTextStyle,
              ),
            ),
            Image(
              image: AssetImage('assets/images/pt_flag.png'),
            ),
            Center(
              child: Text(
                'Português de Portugal',
                style: kBaseTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
