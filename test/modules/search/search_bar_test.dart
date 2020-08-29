import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/modules/search/bloc/bloc.dart';
import 'package:portuguese_dictionary/modules/search/search.dart';

class SearchBlockMock extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

void main() {
  SearchBloc searchBloc;

  setUp(() {
    searchBloc = SearchBlockMock();
  });

  tearDown(() {
    searchBloc.close();
  });

  group('Search Bar', () {
    testWidgets('Shows the search bar', (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state).thenAnswer((_) => StartedState(entries: []));

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MaterialApp(home: Scaffold(body: SearchBar())),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byKey(Key('SearchBar_SearchIcon')), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('Search bar returns icons for search, clear and back',
        (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state).thenAnswer((_) => StartedState(entries: []));

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MaterialApp(home: Scaffold(body: SearchBar())),
        ),
      );

      //Act
      await tester.tap(find.byKey(Key('SearchBar_SearchIcon')));
      await tester.pumpAndSettle();

      //Assert
      expect(find.byKey(Key('SearchBar_Delegate_SearchIcon')), findsOneWidget);
      expect(find.byKey(Key('SearchBar_Delegate_ClearIcon')), findsOneWidget);
      expect(find.byKey(Key('SearchBar_Delegate_BackIcon')), findsOneWidget);
    });

    testWidgets('Shows suggestions after type at least one character',
        (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state).thenAnswer(
        (_) => FilteredSuggestionState(suggestions: [
          'Suggestion1',
          'Suggestion2',
        ]),
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MaterialApp(home: Scaffold(body: SearchBar())),
        ),
      );

      //Act
      await tester.tap(find.byKey(Key('SearchBar_SearchIcon')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'A');
      await tester.pumpAndSettle();

      //Assert
      expect(find.byKey(Key('buildSuggestions_filteredSuggestion')),
          findsOneWidget);
      expect(find.byKey(Key('TermSuggestionsListView')), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
      verify(searchBloc.add(FilterSuggestionEvent(term: 'A'))).called(1);
    });

    testWidgets('Tapping a suggestion returns the suggestion text',
        (WidgetTester tester) async {
      //Arrange
      String suggestionText = "";

      when(searchBloc.state).thenAnswer(
        (_) => FilteredSuggestionState(suggestions: [
          'Suggestion1',
          'Suggestion2',
        ]),
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MaterialApp(
            home: Scaffold(
              body: SearchBar(
                onTapSuggestion: (suggestion) {
                  suggestionText = suggestion;
                },
              ),
            ),
          ),
        ),
      );

      //Act
      await tester.tap(find.byKey(Key('SearchBar_SearchIcon')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'A');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      //Assert
      expect(suggestionText, "Suggestion1");
    });

    testWidgets('Search less than 3 characters shows a disclaimer',
        (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state).thenAnswer((_) => StartedState(entries: []));

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MaterialApp(home: Scaffold(body: SearchBar())),
        ),
      );

      //Act
      await tester.tap(find.byKey(Key('SearchBar_SearchIcon')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'A');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('SearchBar_Delegate_SearchIcon')));
      await tester.pumpAndSettle();

      //Assert
      expect(find.byKey(Key('buildResults_searchLessThanTwoCharacters')),
          findsOneWidget);
    });

    testWidgets('Search more than 3 characters shows results',
        (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state)
          .thenAnswer((_) => FilteredResultState(entries: []));

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MaterialApp(home: Scaffold(body: SearchBar())),
        ),
      );

      //Act
      await tester.tap(find.byKey(Key('SearchBar_SearchIcon')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Bazinga');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('SearchBar_Delegate_SearchIcon')));
      await tester.pumpAndSettle(Duration(seconds: 1));

      //Assert
      expect(find.byKey(Key('SearchBar_SizedBox')), findsNothing);
      verify(searchBloc.add(FilterResultEvent(term: 'Bazinga'))).called(1);
    });

    testWidgets('Tapping clear icon cleans the query search',
        (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state)
          .thenAnswer((_) => FilteredResultState(entries: []));

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MaterialApp(home: Scaffold(body: SearchBar())),
        ),
      );

      //Act
      await tester.tap(find.byKey(Key('SearchBar_SearchIcon')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Bazinga');
      await tester.pumpAndSettle();

      final textAfter = find.text('Bazinga');
      expect(textAfter, findsOneWidget);

      await tester.tap(find.byKey(Key('SearchBar_Delegate_ClearIcon')));
      await tester.pumpAndSettle();

      //Assert
      final textBefore = find.text('Bazinga');
      expect(textBefore, findsNothing);
    });

    testWidgets('Tapping back icon call back function',
        (WidgetTester tester) async {
      //Arrange
      bool isReturnCalled = false;

      when(searchBloc.state)
          .thenAnswer((_) => FilteredResultState(entries: []));

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MaterialApp(
            home: Scaffold(
              body: SearchBar(
                onReturn: () {
                  isReturnCalled = true;
                },
              ),
            ),
          ),
        ),
      );

      //Act
      await tester.tap(find.byKey(Key('SearchBar_SearchIcon')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('SearchBar_Delegate_BackIcon')));
      await tester.pumpAndSettle();

      //Assert
      expect(isReturnCalled, true);
    });
  });
}
