import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';
import 'package:portuguese_dictionary/services/services.dart';

import 'modules/intro/intro.dart';

void main() {
  runApp(Main(
    initialRoute: Routes.intro,
    homeService: HomeService(),
    definitionService: DefinitionService(),
  ));
}

class Main extends StatelessWidget {
  final String? initialRoute;
  final HomeService? homeService;
  final DefinitionService? definitionService;

  const Main({this.initialRoute, this.homeService, this.definitionService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: this.initialRoute,
      routes: {
        Routes.intro: (context) => Intro(),
        Routes.multitab: (context) => Multitab(
              homeService: homeService,
              definitionService: definitionService,
            ),
      },
    );
  }
}
