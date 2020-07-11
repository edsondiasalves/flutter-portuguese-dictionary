import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';
import 'modules/intro/intro.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.intro,
      routes: {
        Routes.intro: (context) => Intro(),
        Routes.multitab: (context) => Multitab(),
      },
    );
  }
}
