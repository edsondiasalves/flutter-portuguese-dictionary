import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/service/definition_service.dart';
import 'package:portuguese_dictionary/widget/bloc/bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final DefinitionService definitionService;

  SearchBloc({@required this.definitionService});

  @override
  SearchState get initialState => LoadingState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is StartEvent) {
      final entries = await this.definitionService.getAllEntries();
      yield StartedState(entries: entries);
    } else if (event is FilterEvent) {
      final entries = await this.definitionService.getAllEntries();
      yield FilteredState(entries: entries);
    }
  }

  @override
  void onTransition(Transition<SearchEvent, SearchState> transition) {
    print(transition);
  }
}
