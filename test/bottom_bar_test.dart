import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/bottom_bar.dart';

void main() {
  group('Bottom bar', () {
    testWidgets('Shows the bottom bar', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomBar(
              currentTab: 0,
            ),
          ),
        ));

        expect(find.byType(BottomNavigationBar), findsOneWidget);
        expect(find.byType(Icon), findsNWidgets(3));
        expect(find.byType(Text), findsNWidgets(3));
      });
    });

    testWidgets('Tapping in the tabs', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        int tabIndex = 0;
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomBar(
              currentTab: tabIndex,
              onTabChange: (newIndex) {
                tabIndex = newIndex;
              },
            ),
          ),
        ));

        expect(tabIndex, 0);

        await tester.tap(find.byIcon(Icons.home));
        await tester.pump();
        expect(tabIndex, 0);

        await tester.tap(find.byIcon(Icons.search));
        await tester.pump();
        expect(tabIndex, 1);

        await tester.tap(find.byIcon(Icons.person));
        await tester.pump();
        expect(tabIndex, 2);
      });
    });
  });
}
