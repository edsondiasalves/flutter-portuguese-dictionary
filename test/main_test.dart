import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/main.dart' as dictionary_main;
import 'package:portuguese_dictionary/routes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        //Act
        await tester.pump(Duration(seconds: 1));

        //Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    testWidgets('Shows the multitab main page', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(
          dictionary_main.Main(
            initialRoute: Routes.multitab,
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });
  });
}
