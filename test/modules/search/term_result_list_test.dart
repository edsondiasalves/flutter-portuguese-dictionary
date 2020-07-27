import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/model/definition.dart';
import 'package:portuguese_dictionary/model/entry.dart';
import 'package:portuguese_dictionary/modules/search/search.dart';

void main() {
  group('Term Result List', () {
    testWidgets('Shows the term result list', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(
        MaterialApp(
            home: Scaffold(
          body: TermResultList(entries: [
            Entry(definitions: [
              Definition(term: 'Term1', meanings: ['Meaning1'])
            ])
          ]),
        )),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byKey(Key('TermResultListView')), findsOneWidget);
      expect(find.text('Term1'), findsOneWidget);
      expect(find.text('Meaning1'), findsOneWidget);
    });
  });
}
