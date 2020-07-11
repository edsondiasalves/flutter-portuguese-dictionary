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
    return Scaffold(
      body: Center(
        child: Text(
          'Intro',
          style: new TextStyle(
            fontSize: 30.0,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
