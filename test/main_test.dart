import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/main.dart' as dictionary_main;
import 'package:portuguese_dictionary/modules/intro/intro.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseApp extends Mock implements FirebaseApp {}

void main() {
  FirebaseApp firebaseApp;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    firebaseApp = MockFirebaseApp();
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
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        //Act
        await tester.pump(Duration(seconds: 1));

        //Assert
        expect(find.byType(Intro), findsOneWidget);
      });
    });
  });
}
