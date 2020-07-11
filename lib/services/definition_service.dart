import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:portuguese_dictionary/model/model.dart';

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

  Future<List<String>> getSuggestionByTerms(String term) async {
    if (term.length == 0) return [];

    final allEntries = await this.getAllEntries();

    final List<String> allSuggestions = [];
    allEntries.forEach((f) {
      allSuggestions.add(f.definitions[0].term);
      allSuggestions.add(f.definitions[1].term);
    });

    final entries = allSuggestions
        .where((e) => e.toLowerCase().startsWith(term.toLowerCase()))
        .toList();

    return entries;
  }
}