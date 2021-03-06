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
      yield* _mapStartEvent();
    } else if (event is FilterSuggestionEvent) {
      yield* _mapFilterSuggestionEvent(event);
    } else if (event is TapTermEvent) {
      yield* _mapTapSuggestionEvent(event);
    } else if (event is FilterResultEvent) {
      yield* _mapFilterResultEvent(event);
    }
  }

  Stream<SearchState> _mapStartEvent() async* {
    yield LoadingState();
    final entries = await this.definitionService.getAllEntries();
    yield StartedState(entries: entries);
  }

  Stream<SearchState> _mapFilterSuggestionEvent(
      FilterSuggestionEvent event) async* {
    yield LoadingState();
    final suggestions =
        await this.definitionService.getSuggestionByTerms(event.term);
    yield FilteredSuggestionState(suggestions: suggestions);
  }

  Stream<SearchState> _mapTapSuggestionEvent(TapTermEvent event) async* {
    yield LoadingState();
    final entry =
        await this.definitionService.getEntryBySuggestion(event.suggestion);
    yield SelectedSuggestionState(entry: entry, suggestion: event.suggestion);
  }

  Stream<SearchState> _mapFilterResultEvent(FilterResultEvent event) async* {
    yield LoadingState();
    final entries = await this.definitionService.getEntriesByTerms(event.term);
    yield FilteredResultState(entries: entries, term: event.term);
  }

  @override
  void onTransition(Transition<SearchEvent, SearchState> transition) {
    print(transition);
  }
}
