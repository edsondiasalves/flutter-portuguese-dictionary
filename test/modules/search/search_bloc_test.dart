import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/model/model.dart';
import 'package:portuguese_dictionary/modules/search/bloc/bloc.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';
import 'package:test/test.dart';

void main() {
  group('SearchBloc', () {
    SearchBloc searchBloc;
    MockDefinitionService mock;

    final fullEntries = [Entry(), Entry()];
    final dummyEntry = Entry(definitions: [Definition(term: "bazinga")]);
    final List<String> dummySuggestion = ['Hello', 'World'];

    setUp(() {
      mock = MockDefinitionService();

      when(mock.getAllEntries()).thenAnswer(
        (_) => Future.value(fullEntries),
      );
      when(mock.getEntriesByTerms("bazinga")).thenAnswer(
        (_) => Future.value([dummyEntry]),
      );
      when(mock.getSuggestionByTerms("Hello")).thenAnswer(
        (_) => Future.value(dummySuggestion),
      );

      searchBloc = SearchBloc(definitionService: mock);
    });

    tearDown(() {
      searchBloc.close();
    });

    test('Initial state is Loading', () {
      expect(searchBloc.initialState, LoadingState());
    });

    blocTest(
      'Start the search',
      build: () => searchBloc,
      act: (bloc) => bloc.add(StartEvent()),
      expect: [LoadingState(), StartedState(entries: fullEntries)],
    );

    blocTest(
      'Filter the result list',
      build: () => searchBloc,
      act: (bloc) => bloc.add(FilterResultEvent(term: "bazinga")),
      expect: [
        LoadingState(),
        FilteredResultState(entries: [dummyEntry])
      ],
    );

    blocTest(
      'Filter the suggestion list',
      build: () => searchBloc,
      act: (bloc) => bloc.add(FilterSuggestionEvent(term: 'Hello')),
      expect: [
        LoadingState(),
        FilteredSuggestionState(suggestions: dummySuggestion)
      ],
    );
  });
}

class MockDefinitionService extends Mock implements DefinitionService {}
