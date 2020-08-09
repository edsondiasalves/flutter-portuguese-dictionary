import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../search.dart';

class Search extends StatelessWidget {
  const Search([key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Search')),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SearchBar(
                onTapSuggestion: (suggestionItem) {
                  BlocProvider.of<SearchBloc>(context)
                      .add(TapTermEvent(suggestion: suggestionItem));
                },
                onReturn: () {
                  BlocProvider.of<SearchBloc>(context).add(StartEvent());
                },
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is StartedState) {
                    return SearchResultList(entries: state.entries);
                  } else if (state is FilteredResultState) {
                    return SearchResultList(entries: state.entries);
                  } else if (state is SelectedSuggestionState) {
                    return EntryDetails(entry: state.entry);
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
