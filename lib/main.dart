import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/service/definition_service.dart';
import 'package:portuguese_dictionary/widget/bloc/search_bloc.dart';
import 'package:portuguese_dictionary/widget/dictionary_search_widget.dart';

import 'widget/bloc/search_event.dart';
import 'widget/bloc/search_state.dart';

void main() => runApp(
      BlocProvider<SearchBloc>(
        create: (context) => SearchBloc(
          definitionService: DefinitionService(),
        ),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Title'),
        ),
        body: DictionarySearchWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.receipt),
          onPressed: () {
            SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);

            if (searchBloc.state is StartedState) {
              searchBloc.add(FilterEvent("Agrafador"));
            } else {
              searchBloc.add(StartEvent());
            }
          },
        ),
      ),
    );
  }
}
