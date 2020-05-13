import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../search.dart';
import '../bloc/bloc.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onTapSuggestion;
  final VoidCallback onReturn;

  SearchBar({this.onTapSuggestion, this.onReturn});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key('SearchBar_SearchIcon'),
      icon: Icon(Icons.search),
      onPressed: () {
        showSearch(
          context: context,
          delegate: _CustomSearchDelegate(
            onTapSuggestion: onTapSuggestion,
            onReturn: onReturn,
          ),
        );
      },
    );
  }
}

class _CustomSearchDelegate extends SearchDelegate {
  final Function(String) onTapSuggestion;
  final VoidCallback onReturn;

  _CustomSearchDelegate({this.onTapSuggestion, this.onReturn});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        key: Key('SearchBar_Delegate_SearchIcon'),
        icon: Icon(Icons.search),
        onPressed: () {
          showResults(context);
        },
      ),
      IconButton(
        key: Key('SearchBar_Delegate_ClearIcon'),
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          key: Key('SearchBar_Delegate_BackIcon'),
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            close(context, null);
            onReturn();
          },
        ),
      ],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return SearchLessThanTwoCharacters(
        key: Key('buildResults_searchLessThanTwoCharacters'),
      );
    } else {
      BlocProvider.of<SearchBloc>(context).add(FilterResultEvent(term: query));
      return Container();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    BlocProvider.of<SearchBloc>(context)
        .add(FilterSuggestionEvent(term: query));

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is FilteredSuggestionState) {
          return SearchSuggestionResult(
            key: Key('buildSuggestions_filteredSuggestion'),
            suggestions: state.suggestions,
            onTapSuggestion: (term) {
              close(context, null);
              onTapSuggestion(term);
            },
          );
        }

        return Container();
      },
    );
  }
}
