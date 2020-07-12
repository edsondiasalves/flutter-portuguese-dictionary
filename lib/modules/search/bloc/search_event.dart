abstract class SearchEvent {
  const SearchEvent();
}

class StartEvent extends SearchEvent {}

class FilterResultEvent extends SearchEvent {
  final String term;

  const FilterResultEvent({this.term});
}

class FilterSuggestionEvent extends SearchEvent {
  final String term;

  const FilterSuggestionEvent({this.term});
}
