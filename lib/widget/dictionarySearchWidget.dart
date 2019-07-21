import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portuguese_dictionary/model/searchResult.dart';
import 'package:portuguese_dictionary/service/dictionaryService.dart';

class DictionarySearchWidget extends StatelessWidget {
  List<SearchResult> searchResultList;
  DictionaryService service;

  DictionarySearchWidget() {
    service = DictionaryService();
    searchResultList = service.getSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Center(
        child: _buildSearchResultList(),
      ),
    );
  }

  ListView _buildSearchResultList() {
    List<ListTile> tiles = List<ListTile>();

    for (var result in this.searchResultList) {
      ListTile tile = ListTile(
        title: Text(result.portugueseTerm),
        subtitle: Text(result.brazilianTerm),
      );

      tiles.add(tile);
    }

    return ListView(
      children: tiles,
    );
  }
}
