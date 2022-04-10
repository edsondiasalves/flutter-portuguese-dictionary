import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/model/definition.dart';
import 'package:portuguese_dictionary/model/entry.dart';
import 'package:portuguese_dictionary/modules/search/bloc/bloc.dart';
import 'package:portuguese_dictionary/modules/search/search.dart';

class SearchBlockMock extends MockBloc<SearchEvent, SearchState> implements SearchBloc {}

void main() {
  late SearchBloc searchBloc;

  setUp(() {
    searchBloc = SearchBlockMock();
  });

  tearDown(() {
    searchBloc.close();
  });

  group('Search Widget', () {
    testWidgets('Shows a list of term when entering for the first time', (WidgetTester tester) async {
      //Arrange
      final searchState = StartedState(entries: []);

      whenListen(
        searchBloc,
        Stream.fromIterable([searchState]),
        initialState: searchState,
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: Search(),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SearchBar), findsOneWidget);
      expect(find.byType(SearchResultList), findsOneWidget);
    });

    testWidgets('Tapping one of the result items in the list', (WidgetTester tester) async {
      //Arrange
      final searchState = StartedState(entries: [
        Entry(definitions: [Definition(term: 'Bazinga term', meanings: [])])
      ]);

      whenListen(
        searchBloc,
        Stream.fromIterable([searchState]),
        initialState: searchState,
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: Search(),
        ),
      );

      //Act
      await tester.pumpAndSettle();

      await tester.tap(find.text('Bazinga term'));
      await tester.pumpAndSettle();

      //Assert
      expect(searchBloc.state, searchState);
    });

    testWidgets('Shows a filtered result list', (WidgetTester tester) async {
      //Arrange
      final searchState = FilteredResultState(entries: []);

      whenListen(
        searchBloc,
        Stream.fromIterable([searchState]),
        initialState: searchState,
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: Search(),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SearchBar), findsOneWidget);
      expect(find.byType(SearchResultList), findsOneWidget);
    });

    testWidgets('Tapping on suggestion calls bloc event', (WidgetTester tester) async {
      //Arrange
      final searchState = FilteredSuggestionState(suggestions: [
        'Suggestion1',
        'Suggestion2',
      ]);

      whenListen(
        searchBloc,
        Stream.fromIterable([searchState]),
        initialState: searchState,
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: Search(),
        ),
      );

      //Act
      await tester.tap(find.byKey(Key('SearchBar_SearchIcon')));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      //Assert
      expect(searchBloc.state, searchState);
    });

    testWidgets('Tapping on back icon calls bloc event', (WidgetTester tester) async {
      //Arrange
      final searchState = FilteredSuggestionState(suggestions: [
        'Suggestion1',
        'Suggestion2',
      ]);

      whenListen(
        searchBloc,
        Stream.fromIterable([searchState]),
        initialState: searchState,
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: Search(),
        ),
      );

      //Act
      await tester.tap(find.byKey(Key('SearchBar_SearchIcon')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('SearchBar_Delegate_BackIcon')));
      await tester.pumpAndSettle();

      //Assert
      expect(searchBloc.state, searchState);
    });

    testWidgets('Shows the details of a entry when clicking in one suggestion ', (WidgetTester tester) async {
      //Arrange
      final searchState = SelectedSuggestionState(
        entry: Entry(
          definitions: [
            Definition(language: "lang1"),
            Definition(language: "lang2"),
          ],
        ),
      );

      whenListen(
        searchBloc,
        Stream.fromIterable([searchState]),
        initialState: searchState,
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: Search(),
        ),
      );

      //Act
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SearchBar), findsOneWidget);
      expect(find.byType(EntryDetails), findsOneWidget);
    });

    testWidgets('Should return to the welcome page', (WidgetTester tester) async {
      //Arrange
      final searchState = SelectedSuggestionState(
        entry: Entry(
          definitions: [
            Definition(language: "lang1"),
            Definition(language: "lang2"),
          ],
        ),
      );

      whenListen(
        searchBloc,
        Stream.fromIterable([searchState]),
        initialState: searchState,
      );

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: Search(),
        ),
      );

      //Act
      await tester.pumpAndSettle();
      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      //Assert
      expect(searchBloc.state, searchState);
    });
  });
}
