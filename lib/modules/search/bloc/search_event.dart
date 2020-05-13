import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class StartEvent extends SearchEvent {
  @override
  List<Object> get props => null;
}

class FilterResultEvent extends SearchEvent {
  final String term;

  const FilterResultEvent({this.term});

  @override
  List<Object> get props => [term];
}

class FilterSuggestionEvent extends SearchEvent {
  final String term;

  const FilterSuggestionEvent({this.term});

  @override
  List<Object> get props => [term];
}
