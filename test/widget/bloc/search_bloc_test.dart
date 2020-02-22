import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/model/definition.dart';
import 'package:portuguese_dictionary/model/entry.dart';
import 'package:portuguese_dictionary/service/definition_service.dart';
import 'package:portuguese_dictionary/widget/bloc/bloc.dart';
import 'package:test/test.dart';

void main() {
  group('SearchBloc', () {
    SearchBloc searchBloc;
    MockDefinitionService mock;

    final fullEntries = [Entry(), Entry()];
    final bazingaEntry = Entry(definitions: [Definition(term: "bazinga")]);

    setUp(() {
      mock = MockDefinitionService();

      when(mock.getAllEntries()).thenAnswer((_) => Future.value(fullEntries));
      when(mock.getEntriesByTerms("bazinga"))
          .thenAnswer((_) => Future.value([bazingaEntry]));

      searchBloc = SearchBloc(definitionService: mock);
    });

    test('Initial state is Loading', () {
      expect(searchBloc.initialState, LoadingState());
    });

    blocTest('Start the search',
        build: () => searchBloc,
        act: (bloc) => bloc.add(StartEvent()),
        expect: [LoadingState(), StartedState(entries: fullEntries)]);

    blocTest('Filter the list',
        build: () => searchBloc,
        act: (bloc) => bloc.add(FilterEvent("bazinga")),
        expect: [
          LoadingState(),
          FilteredState(entries: [bazingaEntry])
        ]);
  });
}

class MockDefinitionService extends Mock implements DefinitionService {}
