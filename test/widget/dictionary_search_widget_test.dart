import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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
    testWidgets('Shows a loading', (WidgetTester tester) async {
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
      expect(find.byType(Scaffold), findsNWidgets(2));
      //expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    /*
    testWidgets('Tap the action button for the first time',
        (WidgetTester tester) async {
      final entries = [Entry(), Entry()];
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
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('Tap the action button for the second time',
        (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(myApp);

      //Act
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      //Assert
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(1));
    });

    */
  });
}
