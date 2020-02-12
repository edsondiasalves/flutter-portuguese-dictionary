import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/model/definition.dart';
import 'package:portuguese_dictionary/model/entry.dart';

void main() {
  group('Entry model', () {
    test('default values should be null', () {
      //Act
      final newEntry = Entry();

      //Assert
      expect(newEntry.id, null);
      expect(newEntry.definitions, null);
    });

    test('initialized values matches', () {
      //Arrange
      final id = 1;
      final definitions = List<Definition>();
      definitions.add(Definition(
          language: 'language',
          term: 'term',
          meaning: 'meaning',
          examples: ['example1', 'example2']));

      //Act
      final entry = Entry(id: id, definitions: definitions);

      //Assert
      expect(entry.id, id);
      expect(entry.definitions, definitions);
    });

    test('should deserialize correctly', () {
      //Arrange
      final serializedData =
          "{\n \"id\":1,\n \"definitions\": [\n {\n \"language\": \"language1\",\n \"term\": \"term1\",\n \"meaning\": \"meaning1\",\n \"examples\": [\n \"example1\"\n ]\n },\n {\n \"language\": \"language2\",\n \"term\": \"term2\",\n \"meaning\": \"meaning2\",\n \"examples\": [\n \"example2\",\n \"example3\"\n ]\n }\n ]\n }";
      final Map<String, dynamic> decoded = jsonDecode(serializedData);

      //Act
      final entry = Entry.fromJson(decoded);

      //Assert
      expect(entry.id, 1);
      expect(entry.definitions.length, 2);
      expect(entry.definitions[0].language, 'language1');
      expect(entry.definitions[0].term, 'term1');
      expect(entry.definitions[0].meaning, 'meaning1');
      expect(entry.definitions[0].examples.length, 1);
      expect(entry.definitions[0].examples[0], 'example1');
      expect(entry.definitions[1].language, 'language2');
      expect(entry.definitions[1].term, 'term2');
      expect(entry.definitions[1].meaning, 'meaning2');
      expect(entry.definitions[1].examples.length, 2);
      expect(entry.definitions[1].examples[0], 'example2');
      expect(entry.definitions[1].examples[1], 'example3');
    });
  });
}
