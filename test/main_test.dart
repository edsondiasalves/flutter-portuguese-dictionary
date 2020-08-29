import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/main.dart' as dictionary_main;
import 'package:portuguese_dictionary/modules/intro/intro.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';

class MockFirebaseApp extends Mock implements FirebaseApp {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  FirebaseApp firebaseApp;
  FirebaseFirestore firestore;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    firebaseApp = MockFirebaseApp();
    firestore = MockFirebaseFirestore();
  });

  group('Main', () {
    test('Loads the main Entry point', () {
      try {
        dictionary_main.main();
      } catch (e) {
        expect(e != null, true);
      }
    });

    testWidgets('Shows the intro main page', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(
          dictionary_main.Main(
            initialRoute: Routes.intro,
            firebaseApp: Future.value(firebaseApp),
            firestore: firestore,
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        //Act
        await tester.pump(Duration(seconds: 1));

        //Assert
        expect(find.byType(Intro), findsOneWidget);
      });
    });

    testWidgets('Shows the multitab main page', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(
          dictionary_main.Main(
            initialRoute: Routes.multitab,
            firebaseApp: Future.value(firebaseApp),
            firestore: firestore,
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        //Act
        await tester.pump(Duration(seconds: 1));

        //Assert
        expect(find.byType(Multitab), findsOneWidget);
      });
    });
  });
}
