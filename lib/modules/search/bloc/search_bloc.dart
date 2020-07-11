import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';

import 'bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final DefinitionService definitionService;

  SearchBloc({@required this.definitionService});

  @override
  SearchState get initialState => LoadingState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is StartEvent) {
      yield LoadingState();
      final entries = await this.definitionService.getAllEntries();
      yield StartedState(entries: entries);
    } else if (event is FilterSuggestionEvent) {
      yield LoadingState();
      final suggestions =
          await this.definitionService.getSuggestionByTerms(event.term);
      yield FilteredSuggestionState(suggestions: suggestions);
    } else if (event is FilterResultEvent) {
      yield LoadingState();
      final entries =
          await this.definitionService.getEntriesByTerms(event.term);
      yield FilteredResultState(entries: entries);
    }
  }

  @override
  void onTransition(Transition<SearchEvent, SearchState> transition) {
    print(transition);
  }
}
