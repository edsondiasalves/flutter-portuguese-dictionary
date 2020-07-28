import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/model/definition.dart';
import 'package:portuguese_dictionary/model/entry.dart';
import 'package:portuguese_dictionary/modules/search/search.dart';

void main() {
  group('Entry Details', () {
    Entry simpleEntry;

    testWidgets('Raise and error if not passing the entry',
        (WidgetTester tester) async {
      //Arrange
      try {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: EntryDetails(),
            ),
          ),
        );

        //Act
        await tester.pump();
      } on AssertionError catch (error) {
        //Assert
        expect(error is AssertionError, true);
      }
    });

    testWidgets('Shows only the terms', (WidgetTester tester) async {
      //Arrange
      simpleEntry = Entry();
      simpleEntry.definitions = [
        Definition(language: "l1", term: "term1"),
        Definition(language: "l2", term: "term2"),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryDetails(
              entry: simpleEntry,
              key: Key('EntryDetails'),
            ),
          ),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byKey(Key('EntryDetails')), findsOneWidget);
      expect(find.text('L1 : term1'), findsOneWidget);
      expect(find.text('L2 : term2'), findsOneWidget);
      expect(find.text('m1'), findsNothing);
      expect(find.text('m2'), findsNothing);
      expect(find.text('Significado:'), findsNothing);
    });

    testWidgets('Shows terms and meanings', (WidgetTester tester) async {
      //Arrange
      simpleEntry = Entry();
      simpleEntry.definitions = [
        Definition(language: "l1", term: "term1", meanings: ['m1']),
        Definition(language: "l2", term: "term2", meanings: ['m2']),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryDetails(
              entry: simpleEntry,
              key: Key('EntryDetails'),
            ),
          ),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byKey(Key('EntryDetails')), findsOneWidget);
      expect(find.text('L1 : term1'), findsOneWidget);
      expect(find.text('L2 : term2'), findsOneWidget);
      expect(find.text('Significado:'), findsNWidgets(2));
      expect(find.text('1 - m1'), findsOneWidget);
      expect(find.text('1 - m2'), findsOneWidget);
    });

    testWidgets('Shows terms and multiple meanings',
        (WidgetTester tester) async {
      //Arrange
      simpleEntry = Entry();
      simpleEntry.definitions = [
        Definition(language: "l1", term: "term1", meanings: ['m1', 'm2']),
        Definition(language: "l2", term: "term2", meanings: ['m3', 'm4']),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryDetails(
              entry: simpleEntry,
              key: Key('EntryDetails'),
            ),
          ),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byKey(Key('EntryDetails')), findsOneWidget);
      expect(find.text('L1 : term1'), findsOneWidget);
      expect(find.text('L2 : term2'), findsOneWidget);
      expect(find.text('Significado:'), findsNWidgets(2));
      expect(find.text('1 - m1'), findsOneWidget);
      expect(find.text('2 - m2'), findsOneWidget);
      expect(find.text('1 - m3'), findsOneWidget);
      expect(find.text('2 - m4'), findsOneWidget);
    });

    testWidgets('Shows terms, meanings and examples',
        (WidgetTester tester) async {
      //Arrange
      simpleEntry = Entry();
      simpleEntry.definitions = [
        Definition(
          language: "l1",
          term: "term1",
          meanings: ['m1'],
          examples: ['e1'],
        ),
        Definition(
          language: "l2",
          term: "term2",
          meanings: ['m2'],
          examples: ['e2'],
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryDetails(
              entry: simpleEntry,
              key: Key('EntryDetails'),
            ),
          ),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byKey(Key('EntryDetails')), findsOneWidget);
      expect(find.text('L1 : term1'), findsOneWidget);
      expect(find.text('L2 : term2'), findsOneWidget);
      expect(find.text('Significado:'), findsNWidgets(2));
      expect(find.text('1 - m1'), findsOneWidget);
      expect(find.text('1 - m2'), findsOneWidget);
      expect(find.text('Exemplo:'), findsNWidgets(2));
      expect(find.text('1 - e1'), findsOneWidget);
      expect(find.text('1 - e2'), findsOneWidget);
    });

    testWidgets('Shows terms, multiple meanings and multiple examples',
        (WidgetTester tester) async {
      //Arrange
      simpleEntry = Entry();
      simpleEntry.definitions = [
        Definition(
            language: "l1",
            term: "term1",
            meanings: ['m1', 'm2'],
            examples: ['e1', 'e2']),
        Definition(
            language: "l2",
            term: "term2",
            meanings: ['m3', 'm4'],
            examples: ['e3', 'e4']),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryDetails(
              entry: simpleEntry,
              key: Key('EntryDetails'),
            ),
          ),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byKey(Key('EntryDetails')), findsOneWidget);
      expect(find.text('L1 : term1'), findsOneWidget);
      expect(find.text('L2 : term2'), findsOneWidget);
      expect(find.text('Significado:'), findsNWidgets(2));
      expect(find.text('1 - m1'), findsOneWidget);
      expect(find.text('2 - m2'), findsOneWidget);
      expect(find.text('1 - m3'), findsOneWidget);
      expect(find.text('2 - m4'), findsOneWidget);
      expect(find.text('Exemplo:'), findsNWidgets(2));
      expect(find.text('1 - e1'), findsOneWidget);
      expect(find.text('2 - e2'), findsOneWidget);
      expect(find.text('1 - e3'), findsOneWidget);
      expect(find.text('2 - e4'), findsOneWidget);
    });
  });
}
