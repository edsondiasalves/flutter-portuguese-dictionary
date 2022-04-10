import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends SearchEvent {}

class FilterResultEvent extends SearchEvent {
  final String? term;

  const FilterResultEvent({this.term});

  @override
  List<Object> get props => [term!];
}

class FilterSuggestionEvent extends SearchEvent {
  final String? term;

  const FilterSuggestionEvent({this.term});

  @override
  List<Object> get props => [term!];
}

class TapTermEvent extends SearchEvent {
  final String? suggestion;

  const TapTermEvent({this.suggestion});

  @override
  List<Object> get props => [suggestion!];
}
