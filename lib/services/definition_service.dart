import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:portuguese_dictionary/model/entry.dart';

class DefinitionService {
  Future<List<Entry>> getAllEntries() async {
    final definitions = await rootBundle.loadString(
      'assets/data/definitions.json',
    );

    final entryMap = jsonDecode(definitions);
    final entries = entryMap.map((_) => Entry.fromJson(_)).toList();
    List<Entry> entryList = List<Entry>.from(entries);

    return entryList;
  }

  Future<List<Entry>> getEntriesByTerms(String term) async {
    List<Entry> allEntries = await this.getAllEntries();

    List<Entry> entries = allEntries
        .where((e) => e.definitions.any((d) => d.term == term))
        .toList();

    return entries;
  }

  List<String> getSuggestionByTerms(String term) {
    if (term.length == 0) return [];

    final allSuggestions = [
      'Agrafador',
      'Grampeador',
      'Balneário',
      'Vestiário'
    ];

    final entries = allSuggestions
        .where((e) => e.toLowerCase().startsWith(term.toLowerCase()))
        .toList();
    return entries;
  }
}
