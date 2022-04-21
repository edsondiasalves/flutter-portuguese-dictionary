import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:portuguese_dictionary/model/model.dart';

class DefinitionService {
  final List<Entry> _entries = [];

  Future<List<Entry>> getAllEntries() async {
    if (_entries.length == 0) {
      final entriesFile = await rootBundle.loadString('assets/data/definitions.json');
      var entriesJson = jsonDecode(entriesFile);
      entriesJson.forEach((entry) => _entries.add(Entry.fromJson(entry)));
    }

    return _entries;
  }

  Future<List<Entry>> getEntriesByTerms(String? term) async {
    List<Entry> allEntries = await this.getAllEntries();

    List<Entry> entries =
        allEntries.where((e) => e.definitions!.any((d) => d.term!.toLowerCase().contains(term!.toLowerCase()))).toList();

    return entries;
  }

  Future<List<String?>> getSuggestionByTerms(String term) async {
    if (term.length == 0) return [];

    final allEntries = await this.getAllEntries();

    final List<String?> allSuggestions = [];
    allEntries.forEach((f) {
      f.definitions!.forEach((d) {
        if (!allSuggestions.contains(d.term)) {
          allSuggestions.add(d.term);
        }
      });
    });

    final entries = allSuggestions.where((e) => e!.toLowerCase().contains(term.toLowerCase())).toList();

    return entries;
  }

  Future<Entry> getEntryBySuggestion(String? suggestion) async {
    final allEntries = await this.getAllEntries();

    Entry entry = allEntries.where((e) => e.definitions!.any((d) => d.term == suggestion)).toList().first;

    return entry;
  }
}
