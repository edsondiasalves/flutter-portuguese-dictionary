import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';
import 'package:portuguese_dictionary/services/home_service.dart';

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
        Routes.multitab: (context) => Multitab(
              homeService: HomeService(
                collection: Firestore.instance.collection('news'),
              ),
              definitionService: DefinitionService(
                collection: Firestore.instance.collection('entries'),
              ),
            ),
      },
    );
  }
}
