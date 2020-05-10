import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/modules/search/bloc/bloc.dart';
import 'package:portuguese_dictionary/modules/search/search_bar.dart';
import 'package:portuguese_dictionary/modules/search/search_result_list.dart';

import 'bloc/bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Portuguese Dictionary'),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SearchBar(
                onTapSuggestion: (suggestionItem) {
                  BlocProvider.of<SearchBloc>(context).add(
                    FilterResultEvent(term: suggestionItem),
                  );
                },
                onReturn: () {
                  BlocProvider.of<SearchBloc>(context).add(
                    StartEvent(),
                  );
                },
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        key: Key('ProgressIndicator'),
                      ),
                    );
                  }
                  return SearchResultList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
