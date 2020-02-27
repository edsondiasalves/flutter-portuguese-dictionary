import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/widget/bloc/bloc.dart';

import 'bloc/search_bloc.dart';

class DictionarySearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return BlocBuilder(
      bloc: searchBloc,
      builder: (context, state) {
        print(state);
        if (state is LoadingState) {
          return Center(
              child: CircularProgressIndicator(
            key: Key('LoadingIndicator'),
          ));
        } else {
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
      },
    );
  }
}
