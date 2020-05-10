import 'package:flutter/material.dart';

class SearchSuggestionResult extends StatelessWidget {
  final List<String> suggestions;
  final Function(String) onTapSuggestion;

  const SearchSuggestionResult(
      {Key key, this.suggestions, this.onTapSuggestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tiles = List<ListTile>();

    for (var suggestion in suggestions) {
      ListTile tile = ListTile(
        title: Text(suggestion),
        onTap: () => onTapSuggestion(suggestion),
      );

      tiles.add(tile);
    }

    return ListView(
      key: Key('TermSuggestionsListView'),
      children: tiles,
    );
  }
}
