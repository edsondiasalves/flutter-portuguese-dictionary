import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/main.dart';

void main() {
  group('Main', () {
    testWidgets('Shows the main app', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(Main());

        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });
  });
}
