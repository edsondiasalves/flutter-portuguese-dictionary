import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/model/definition.dart';
import 'package:portuguese_dictionary/model/entry.dart';
import 'package:portuguese_dictionary/widget/bloc/bloc.dart';
import 'package:portuguese_dictionary/widget/dictionary_search_widget.dart';

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

  group('Dictionary Search Widget', () {
    testWidgets('Shows a progress indicator', (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state).thenAnswer((_) => LoadingState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MaterialApp(
            home: Scaffold(
              body: DictionarySearchWidget(),
            ),
          ),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Shows a list of terms', (WidgetTester tester) async {
      final entries = [
        Entry(definitions: [Definition(term: 'bazinga', meaning: 'bazinga')])
      ];
      when(searchBloc.state).thenAnswer((_) => StartedState(entries: entries));

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MaterialApp(
            home: Scaffold(
              body: DictionarySearchWidget(),
            ),
          ),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
    });
  });
}
