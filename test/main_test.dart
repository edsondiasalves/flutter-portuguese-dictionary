import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/main.dart';
import 'package:portuguese_dictionary/modules/intro/intro.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';

void main() {
  group('Main', () {
    testWidgets('Shows the intro main page', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(
          Main(
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
          Main(
            initialRoute: Routes.multitab,
          ),
        );

        expect(find.byType(Multitab), findsOneWidget);
      });
    });
  });
}
