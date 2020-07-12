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
  });
}
