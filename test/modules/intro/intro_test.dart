import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/modules/intro/intro.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';

class MockCollectionReference extends Mock implements CollectionReference {}

void main() {
  CollectionReference collectionReference;
  setUp(() {
    collectionReference = MockCollectionReference();
  });

  group('Intro Widget', () {
    testWidgets('Shows the intro information', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: Intro()));

        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Image), findsNWidgets(2));
        expect(find.text('Português do Brasil'), findsOneWidget);
        expect(find.text('Vs'), findsOneWidget);
        expect(find.text('Português de Portugal'), findsOneWidget);
      });
    });

    testWidgets('Calls multitab after intro time', (WidgetTester tester) async {
      //Arrange

      await tester.pumpWidget(
        MaterialApp(
          home: Intro(),
          routes: {
            Routes.multitab: (context) => Multitab(
                  entriesCollection: collectionReference,
                  newsCollection: collectionReference,
                ),
          },
        ),
      );

      //Act
      await tester.pump(Duration(seconds: 3));

      //Assert
      expect(find.byType(Multitab), findsOneWidget);
    });
  });
}
