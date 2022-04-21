import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../search.dart';

class SearchBar extends StatelessWidget {
  final Function(String)? onTapSuggestion;
  final VoidCallback? onReturn;

  SearchBar({this.onTapSuggestion, this.onReturn});

  @override
  Widget build(BuildContext context) {
    String? _queryText = "";
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.all(
                const Radius.circular(15),
              ),
            ),
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is FilteredResultState) {
                  _queryText = state.term;
                } else if (state is SelectedSuggestionState) {
                  _queryText = state.suggestion;
                }
                FocusScope.of(context).unfocus();
                return TextField(
                  controller: TextEditingController(text: _queryText),
                  textInputAction: TextInputAction.search,
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: _CustomSearchDelegate(
                        onReturn: () {
                          _queryText = '';
                          this.onReturn!();
                        },
                        onTapSuggestion: this.onTapSuggestion,
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: Icon(
                      Icons.search,
                      key: Key('SearchBar_SearchIcon'),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomSearchDelegate extends SearchDelegate {
  Function(String)? onTapSuggestion;
  VoidCallback? onReturn;

  _CustomSearchDelegate({
    this.onTapSuggestion,
    this.onReturn,
  });

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
            onReturn!();
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
      Future(() {
        Navigator.of(context).pop();
      });
      return SizedBox(key: Key('SearchBar_SizedBox'));
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
              close(context, 'null');
              onTapSuggestion!(term!);
            },
          );
        }

        return Container();
      },
    );
  }
}
