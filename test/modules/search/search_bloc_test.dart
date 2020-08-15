import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/model/model.dart';
import 'package:portuguese_dictionary/modules/search/bloc/bloc.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';
import 'package:test/test.dart';

class MockDefinitionService extends Mock implements DefinitionService {}

void main() {
  group('SearchBloc', () {
    SearchBloc searchBloc;
    MockDefinitionService definitionService;

    final fullEntries = [Entry(), Entry()];
    final dummyEntry = Entry(definitions: [Definition(term: 'bazinga')]);
    final List<String> dummySuggestion = ['Hello', 'World'];

    setUp(() {
      definitionService = MockDefinitionService();

      when(definitionService.getAllEntries()).thenAnswer(
        (_) => Future.value(fullEntries),
      );
      when(definitionService.getEntriesByTerms('bazinga')).thenAnswer(
        (_) => Future.value([dummyEntry]),
      );
      when(definitionService.getSuggestionByTerms('Hello')).thenAnswer(
        (_) => Future.value(dummySuggestion),
      );
      when(definitionService.getEntryBySuggestion('Agrafador')).thenAnswer(
        (_) => Future.value(dummyEntry),
      );

      searchBloc = SearchBloc(definitionService: definitionService);
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
      act: (bloc) => bloc.add(FilterResultEvent(term: 'bazinga')),
      expect: [
        LoadingState(),
        FilteredResultState(entries: [dummyEntry], term: 'bazinga')
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

    blocTest(
      'Filter the suggestion list',
      build: () => searchBloc,
      act: (bloc) => bloc.add(TapTermEvent(suggestion: 'Agrafador')),
      expect: [
        LoadingState(),
        SelectedSuggestionState(entry: dummyEntry, suggestion: 'Agrafador')
      ],
    );
  });
}
