import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:portuguese_dictionary/service/definition_service.dart';
import 'package:portuguese_dictionary/widget/bloc/bloc.dart';

import 'bloc/search_bloc.dart';

class DictionarySearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(definitionService: DefinitionService()),
      child: SRL(),
    );
  }
}

class SRL extends StatelessWidget {
  SearchBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SearchBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          print(state);
          if (state is LoadingState) {
            return _returnLoadingSpinner();
          } else {
            return _returnListView(state);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.receipt),
        onPressed: () {
          if (bloc.state is StartedState) {
            bloc.add(FilterEvent("Agrafador"));
          } else {
            bloc.add(StartEvent());
          }
        },
      ),
    );
  }

  ListView _returnListView(SearchState state) {
    List<ListTile> tiles = List<ListTile>();

    for (var result in state.entries) {
      ListTile tile = ListTile(
        title: Text(result.definitions[0].term),
        subtitle: Text(result.definitions[0].meaning),
      );

      tiles.add(tile);
    }
    return ListView(
      children: tiles,
    );
  }

  Widget _returnLoadingSpinner() {
    return SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );
  }
}
