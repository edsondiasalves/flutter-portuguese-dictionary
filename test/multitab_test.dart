import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/bottom_bar.dart';
import 'package:portuguese_dictionary/modules/home/home.dart';
import 'package:portuguese_dictionary/modules/modules.dart';
import 'package:portuguese_dictionary/multitab.dart';

void main() {
  group('Multitab', () {
    testWidgets('Shows the multitab widget', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: Multitab()));

        expect(find.byType(BottomBar), findsOneWidget);
      });
    });

    testWidgets('Loads only the first tab', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: Multitab()));

        expect(find.byType(BottomBar), findsOneWidget);

        expect(find.byKey(Key('offstage0')), findsOneWidget);
        expect(find.byType(Home), findsOneWidget);
        expect(find.byKey(Key('multitab_home')), findsOneWidget);

        expect(find.byKey(Key('offstage1')), findsOneWidget);
        expect(find.byType(Search), findsNothing);
        expect(find.byKey(Key('multitab_search')), findsNothing);

        expect(find.byKey(Key('offstage2')), findsOneWidget);
        expect(find.byType(Profile), findsNothing);
        expect(find.byKey(Key('multitab_profile')), findsNothing);
      });
    });

    testWidgets('Tapping on the first tab only loads the Home module',
        (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: Multitab()));

        await tester.tap(find.byIcon(Icons.home));
        await tester.pump();

        expect(find.byKey(Key('offstage0')), findsOneWidget);
        expect(find.byType(Home), findsOneWidget);
        expect(find.byKey(Key('multitab_home')), findsOneWidget);

        expect(find.byKey(Key('offstage1')), findsOneWidget);
        expect(find.byType(Search), findsNothing);
        expect(find.byKey(Key('multitab_search')), findsNothing);

        expect(find.byKey(Key('offstage2')), findsOneWidget);
        expect(find.byType(Profile), findsNothing);
        expect(find.byKey(Key('multitab_profile')), findsNothing);
      });
    });

    testWidgets('Tapping on the second tab only loads the Search module',
        (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: Multitab()));

        await tester.tap(find.byIcon(Icons.search));
        await tester.pump();

        expect(find.byKey(Key('offstage0')), findsOneWidget);
        expect(find.byType(Home), findsNothing);
        expect(find.byKey(Key('multitab_home')), findsNothing);

        expect(find.byKey(Key('offstage1')), findsOneWidget);
        expect(find.byType(Search), findsOneWidget);
        expect(find.byKey(Key('multitab_search')), findsOneWidget);

        expect(find.byKey(Key('offstage2')), findsOneWidget);
        expect(find.byType(Profile), findsNothing);
        expect(find.byKey(Key('multitab_profile')), findsNothing);
      });
    });

    testWidgets('Tapping on the third tab only loads the Profile module',
        (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: Multitab()));

        await tester.tap(find.byIcon(Icons.person));
        await tester.pump();

        expect(find.byKey(Key('offstage0')), findsOneWidget);
        expect(find.byType(Home), findsNothing);
        expect(find.byKey(Key('multitab_home')), findsNothing);

        expect(find.byKey(Key('offstage1')), findsOneWidget);
        expect(find.byType(Search), findsNothing);
        expect(find.byKey(Key('multitab_search')), findsNothing);

        expect(find.byKey(Key('offstage2')), findsOneWidget);
        expect(find.byType(Profile), findsOneWidget);
        expect(find.byKey(Key('multitab_profile')), findsOneWidget);
      });
    });
  });
}
