import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/modules/search/search.dart';

void main() {
  group('Search No Results Found', () {
    testWidgets('Shows text information', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(MaterialApp(home: SearchNoResultsFound()));

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(Text), findsOneWidget);
    });
  });
}
