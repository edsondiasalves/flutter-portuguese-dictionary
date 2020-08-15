import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/model/entry.dart';

abstract class SearchState extends Equatable {}

class LoadingState extends SearchState {
  LoadingState();

  @override
  List<Object> get props => null;
}

class StartedState extends SearchState {
  final List<Entry> entries;
  StartedState({@required this.entries});

  @override
  List<Object> get props => [entries];
}

class FilteredResultState extends SearchState {
  final String term;
  final List<Entry> entries;
  FilteredResultState({@required this.entries, this.term});

  @override
  List<Object> get props => [entries, term];
}

class FilteredSuggestionState extends SearchState {
  final List<String> suggestions;
  FilteredSuggestionState({@required this.suggestions});

  @override
  List<Object> get props => [suggestions];
}

class SelectedSuggestionState extends SearchState {
  final String suggestion;
  final Entry entry;
  SelectedSuggestionState({@required this.entry, this.suggestion});

  @override
  List<Object> get props => [entry, suggestion];
}
