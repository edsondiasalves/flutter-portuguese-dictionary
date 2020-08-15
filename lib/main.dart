import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';

import 'modules/intro/intro.dart';

void main() => runApp(Main(
      initialRoute: Routes.intro,
    ));

class Main extends StatelessWidget {
  final String initialRoute;

  const Main({this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: this.initialRoute,
      routes: {
        Routes.intro: (context) => Intro(),
        Routes.multitab: (context) => Multitab(),
      },
    );
  }
}
