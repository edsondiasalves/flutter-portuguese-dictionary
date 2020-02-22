import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class StartEvent extends SearchEvent {
  @override
  List<Object> get props => null;
}

class FilterEvent extends SearchEvent {
  String term;

  FilterEvent([String term]) {
    this.term = term;
  }

  @override
  List<Object> get props => null;
}
