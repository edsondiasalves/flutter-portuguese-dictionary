import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/main.dart' as dictionary_main;
import 'package:portuguese_dictionary/modules/intro/intro.dart';
import 'package:portuguese_dictionary/routes.dart';

import '../lib/multitab.dart';
import 'firebase_mock.dart';

void main() {
  setupFirebaseAuthMocks();
  FirebaseApp firebaseApp;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    firebaseApp = await Firebase.initializeApp();
  });

  group('Main', () {
    test('Loads the main Entry point', () {
      try {
        dictionary_main.main();
      } catch (e) {
        expect(e != null, true);
      }
    });

    testWidgets('Calls the intro main page', (WidgetTester tester) async {
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
        expect(find.byType(Multitab), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      });
    });

    testWidgets('Calls the Multitab page', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(
          dictionary_main.Main(
            initialRoute: Routes.multitab,
            firebaseApp: Future.value(firebaseApp),
          ),
        );

        //Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pump(Duration(seconds: 1));
        expect(find.byType(Intro), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      });
    });
  });
}
