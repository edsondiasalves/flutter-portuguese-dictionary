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

    return entries;
  }

  Future<List<Entry>> getEntries(String language) async {
    final definitions = await rootBundle.loadString(
      'assets/data/definitions.json',
    );

    final entryMap = jsonDecode(definitions);
    final entries = entryMap.map((_) => Entry.fromJson(_)).toList();

    return entries;
  }
}
