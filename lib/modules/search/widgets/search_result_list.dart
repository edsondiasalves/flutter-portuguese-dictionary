import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/model/entry.dart';

import '../search.dart';

class SearchResultList extends StatelessWidget {
  final List<Entry>? entries;
  const SearchResultList({this.entries});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TermResultList(
        entries: entries,
      ),
    );
  }
}
