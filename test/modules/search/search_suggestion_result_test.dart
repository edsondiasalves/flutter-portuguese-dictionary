import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/modules/search/search.dart';

void main() {
  group('Search Suggestion Result', () {
    testWidgets('Shows the suggestion results', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchSuggestionResult(suggestions: [
              'suggestion1',
              'suggestion2',
            ]),
          ),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byKey(Key('TermSuggestionsListView')), findsOneWidget);
    });

    testWidgets(
        'Tapping the first suggestion returning the correct suggestion title',
        (WidgetTester tester) async {
      //Arrange
      String? suggestionTitle;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchSuggestionResult(
              suggestions: [
                'suggestion1',
                'suggestion2',
              ],
              onTapSuggestion: (suggestion) {
                suggestionTitle = suggestion;
              },
            ),
          ),
        ),
      );

      //Act
      await tester.pump();
      await tester.tap(find.byType(ListTile).first);

      //Assert
      expect(suggestionTitle, "suggestion1");
    });

    testWidgets(
        'Tapping the last suggestion returning the correct suggestion title',
        (WidgetTester tester) async {
      //Arrange
      String? suggestionTitle;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchSuggestionResult(
              suggestions: [
                'suggestion1',
                'suggestion2',
              ],
              onTapSuggestion: (suggestion) {
                suggestionTitle = suggestion;
              },
            ),
          ),
        ),
      );

      //Act
      await tester.pump();
      await tester.tap(find.byType(ListTile).last);

      //Assert
      expect(suggestionTitle, "suggestion2");
    });
  });
}
