import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:portuguese_dictionary/model/model.dart';

class DefinitionService {
  final CollectionReference collection;

  DefinitionService({this.collection});

  List<Entry> _entryList = [];

  Future<List<Entry>> getAllEntries() async {
    if (_entryList.length == 0) {
      final documentEntries = await collection.getDocuments();

      documentEntries.documents.forEach((element) {
        _entryList.add(Entry.fromJson(element.data));
      });
    }

    return _entryList;
  }

  Future<List<Entry>> getEntriesByTerms(String term) async {
    List<Entry> allEntries = await this.getAllEntries();

    List<Entry> entries = allEntries
        .where((e) => e.definitions
            .any((d) => d.term.toLowerCase().contains(term.toLowerCase())))
        .toList();

    return entries;
  }

  Future<List<String>> getSuggestionByTerms(String term) async {
    if (term.length == 0) return [];

    final allEntries = await this.getAllEntries();

    final List<String> allSuggestions = [];
    allEntries.forEach((f) {
      f.definitions.forEach((d) {
        if (!allSuggestions.contains(d.term)) {
          allSuggestions.add(d.term);
        }
      });
    });

    final entries = allSuggestions
        .where((e) => e.toLowerCase().contains(term.toLowerCase()))
        .toList();

    return entries;
  }

  Future<Entry> getEntryBySuggestion(String suggestion) async {
    final allEntries = await this.getAllEntries();

    Entry entry = allEntries
        .where((e) => e.definitions.any((d) => d.term == suggestion))
        .toList()
        .first;

    return entry;
  }

  Future<void> insertEntriesFromFile() async {
    final entriesFile = await rootBundle.loadString(
      'assets/data/definitions.json',
    );

    List<dynamic> entriesJson = jsonDecode(entriesFile);
    final entries = collection;
    entriesJson.forEach((entry) => entries.add(entry));
    return;
  }
}
