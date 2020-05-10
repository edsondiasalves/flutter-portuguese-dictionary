import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portuguese_dictionary/model/entry.dart';

class TermResultList extends StatelessWidget {
  final List<Entry> entries;

  const TermResultList({@required this.entries});

  @override
  Widget build(BuildContext context) {
    final tiles = List<ListTile>();

    for (var result in entries) {
      ListTile tile = ListTile(
        title: Text(result.definitions[0].term),
        subtitle: Text(result.definitions[0].meaning),
        isThreeLine: true,
      );

      tiles.add(tile);
    }

    return ListView(
      key: Key('TermResultListView'),
      children: tiles,
    );
  }
}
