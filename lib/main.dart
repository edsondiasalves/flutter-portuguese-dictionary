import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';

import 'modules/intro/intro.dart';

int main() {
  runApp(Main(initialRoute: Routes.intro));
  return 1;
}

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
