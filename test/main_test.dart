import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/main.dart';
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

  group('MyApp Widget', () {
    testWidgets('Shows a progress indicator', (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state).thenAnswer((_) => LoadingState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MyApp(),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(DictionarySearchWidget), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('Raise StartEvent', (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state).thenAnswer((_) => LoadingState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MyApp(),
        ),
      );

      //Act
      await tester.pump();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      //Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(DictionarySearchWidget), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('Raise FilterEvent', (WidgetTester tester) async {
      //Arrange
      when(searchBloc.state).thenAnswer((_) => LoadingState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: searchBloc,
          child: MyApp(),
        ),
      );

      //Act
      await tester.pump();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      //Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(DictionarySearchWidget), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });
}
