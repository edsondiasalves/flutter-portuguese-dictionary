import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/modules/search/search.dart';

void main() {
  group('Search Result List', () {
    testWidgets('Shows the result list', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(
        MaterialApp(
            home: Column(
          children: <Widget>[
            SearchResultList(entries: []),
          ],
        )),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(TermResultList), findsOneWidget);
    });
  });
}
