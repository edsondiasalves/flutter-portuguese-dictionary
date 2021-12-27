import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/main.dart';
import 'package:portuguese_dictionary/modules/intro/intro.dart';
import 'package:portuguese_dictionary/routes.dart';
import 'package:portuguese_dictionary/services/services.dart';

import '../lib/multitab.dart';

void main() {
  setUpAll(() async {});

  group('Main', () {
    testWidgets('Calls the intro main page', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(
        Main(
          initialRoute: Routes.intro,
          homeService: HomeService(),
          definitionService: DefinitionService(),
        ),
      );

      //Act
      await tester.pump(Duration(seconds: 3));

      //Assert
      expect(find.byType(Intro), findsOneWidget);
      expect(find.byType(Multitab), findsNothing);
    });

    testWidgets('Calls the Multi Tab page', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(
        Main(
          initialRoute: Routes.multitab,
          homeService: HomeService(),
          definitionService: DefinitionService(),
        ),
      );

      //Assert
      await tester.pump(Duration(seconds: 3));

      expect(find.byType(Intro), findsNothing);
      expect(find.byKey(Key('multitab_home')), findsOneWidget);
    });
  });
}
