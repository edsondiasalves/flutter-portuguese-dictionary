import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';

import '../bloc/bloc.dart';
import '../search.dart';

class Search extends StatelessWidget {
  final searchBloc = SearchBloc(definitionService: DefinitionService());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => searchBloc..add(StartEvent()),
        ),
      ],
      child: MaterialApp(
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
                    searchBloc.add(FilterResultEvent(term: suggestionItem));
                  },
                  onReturn: () {
                    searchBloc.add(StartEvent());
                  },
                ),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is StartedState) {
                      return SearchResultList(entries: state.entries);
                    } else if (state is FilteredResultState) {
                      return SearchResultList(entries: state.entries);
                    }
                    return SizedBox();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
