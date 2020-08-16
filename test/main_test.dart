import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/main.dart' as dictionary_main;
import 'package:portuguese_dictionary/modules/intro/intro.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';

void main() {
  group('Main', () {
    test('Loads the main Entry point', () {
      expect(dictionary_main.main(), 1);
    });

    testWidgets('Shows the intro main page', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(
          dictionary_main.Main(
            initialRoute: Routes.intro,
          ),
        );

        expect(find.byType(Intro), findsOneWidget);
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

        expect(find.byType(Multitab), findsOneWidget);
      });
    });
  });
}
