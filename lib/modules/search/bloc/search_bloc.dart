import 'package:bloc/bloc.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';

import 'bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final DefinitionService? definitionService;

  SearchBloc({required this.definitionService}) : super(LoadingState()) {
    on<StartEvent>((event, emit) async {
      await _mapStartEvent(emit);
    });

    on<FilterSuggestionEvent>((event, emit) async {
      await _mapFilterSuggestionEvent(event, emit);
    });

    on<TapTermEvent>((event, emit) async {
      await _mapTapSuggestionEvent(event, emit);
    });

    on<FilterResultEvent>((event, emit) async {
      await _mapFilterResultEvent(event, emit);
    });
  }

  Future<void> _mapStartEvent(Emitter<SearchState> emit) async {
    emit(LoadingState());
    final entries = await this.definitionService!.getAllEntries();
    emit(StartedState(entries: entries));
  }

  Future<void> _mapFilterSuggestionEvent(
      FilterSuggestionEvent event, Emitter<SearchState> emit) async {
    emit(LoadingState());
    final suggestions =
        await this.definitionService!.getSuggestionByTerms(event.term!);
    emit(FilteredSuggestionState(suggestions: suggestions));
  }

  Future<void> _mapTapSuggestionEvent(
      TapTermEvent event, Emitter<SearchState> emit) async {
    emit(LoadingState());
    final entry =
        await this.definitionService!.getEntryBySuggestion(event.suggestion);
    emit(SelectedSuggestionState(entry: entry, suggestion: event.suggestion));
  }

  Future<void> _mapFilterResultEvent(
      FilterResultEvent event, Emitter<SearchState> emit) async {
    emit(LoadingState());
    final entries = await this.definitionService!.getEntriesByTerms(event.term);
    emit(FilteredResultState(entries: entries, term: event.term));
  }
}
