import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/model/entry.dart';
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

  group('Search Widget', () {
    testWidgets('Only show the text Search on entering for the first time',
        (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state).thenAnswer((_) => StartedState(entries: []));

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
      expect(find.text('Search'), findsNWidgets(2));
    });

    testWidgets('Shows a filtered result list', (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state)
          .thenAnswer((_) => FilteredResultState(entries: []));

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

    testWidgets('Tapping on suggestion calls bloc event',
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
          child: Search(),
        ),
      );

      //Act
      await tester.tap(find.byKey(Key('SearchBar_SearchIcon')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Bazinga');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      //Assert
      verify(searchBloc.add(any)).called(4);
    });

    testWidgets('Tapping on back icon calls bloc event',
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
          child: Search(),
        ),
      );

      //Act
      await tester.tap(find.byKey(Key('SearchBar_SearchIcon')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('SearchBar_Delegate_BackIcon')));
      await tester.pumpAndSettle();

      //Assert
      verify(searchBloc.add(any)).called(3);
    });

    testWidgets('Shows the details of a entry', (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state).thenAnswer(
        (_) => SelectedSuggestionState(entry: Entry()),
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
  });
}
