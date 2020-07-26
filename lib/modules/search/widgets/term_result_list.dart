import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/model/model.dart';

class TermResultList extends StatelessWidget {
  final List<Entry> entries;

  const TermResultList({Key key, @required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tiles = List<ListTile>();

    for (var result in entries) {
      ListTile tile = ListTile(
        title: Text(result.definitions[0].term),
        subtitle: Text(result.definitions[0].meanings[0]),
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
