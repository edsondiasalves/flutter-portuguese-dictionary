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

  Future<List<Entry>> getEntriesByLanguage(String language) async {
    List<Entry> allEntries = await this.getAllEntries();

    List<Entry> entries = allEntries.where((_) => _.definitions.length == 2);

    return allEntries;
  }
}
