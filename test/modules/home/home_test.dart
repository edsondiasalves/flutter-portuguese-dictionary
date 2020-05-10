import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/modules/home/bloc/bloc.dart';
import 'package:portuguese_dictionary/modules/home/home.dart';
import 'package:portuguese_dictionary/modules/search/bloc/bloc.dart';
import 'package:portuguese_dictionary/modules/search/search.dart';

class SearchBlockMock extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class HomeBlockMock extends MockBloc<HomeEvent, HomeState> implements HomeBloc {
}

void main() {
  SearchBloc searchBloc;
  HomeBloc homeBloc;

  setUp(() {
    searchBloc = SearchBlockMock();
    homeBloc = HomeBlockMock();
  });

  tearDown(() {
    searchBloc.close();
    homeBloc.close();
  });

  group('Home Widget', () {
    testWidgets('Shows a progress indicator', (WidgetTester tester) async {
      //Arrange
      when(homeBloc.state).thenAnswer((_) => HomeLoadingState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: homeBloc,
          child: Home(),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(Home), findsOneWidget);
      expect(find.byType(SearchBar), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
