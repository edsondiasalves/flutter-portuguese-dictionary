import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/modules/intro/intro.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';

void main() {
  setUp(() {});

  tearDown(() {});

  group('Intro Widget', () {
    testWidgets('Shows the intro text', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: Intro()));

        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byKey(Key('Intro_CenterText')), findsOneWidget);
      });
    });

    testWidgets('Calls multitab after intro time', (WidgetTester tester) async {
      //Arrange

      await tester.pumpWidget(MaterialApp(
        home: Intro(),
        routes: {
          Routes.multitab: (context) => Multitab(),
        },
      ));

      //Act
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      expect(find.byType(Multitab), findsOneWidget);
    });
  });
}
