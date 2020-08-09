import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/model/model.dart';
import 'package:portuguese_dictionary/modules/search/bloc/bloc.dart';

class TermResultList extends StatelessWidget {
  final List<Entry> entries;

  const TermResultList({Key key, @required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cards = List<Card>();

    for (var result in entries) {
      final definitions = result.definitions;
      String meaning = 'No provided';

      for (var definition in definitions) {
        if (definition.meanings.length > 0) {
          meaning = definition.meanings[0];
        }

        final card = Card(
          child: InkWell(
            child: ListTile(
              title: Text(definition.term),
              subtitle: Text(meaning),
            ),
            onTap: () {
              BlocProvider.of<SearchBloc>(context)
                  .add(TapTermEvent(suggestion: definition.term));
            },
          ),
        );

        cards.add(card);
      }
    }

    return ListView(
      key: Key('TermResultListView'),
      children: cards,
    );
  }
}
