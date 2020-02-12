import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/model/entry.dart';

abstract class SearchState extends Equatable {
  final List<Entry> entries;

  const SearchState({this.entries});
}

class StartedState extends SearchState {
  const StartedState({@required List<Entry> entries}) : super(entries: entries);

  @override
  List<Object> get props => [entries];
}

class FilteredState extends SearchState {
  const FilteredState({@required List<Entry> entries})
      : super(entries: entries);

  @override
  List<Object> get props => [entries];
}
