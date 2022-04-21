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
      final definitions = List<Definition>.empty(growable: true);
      definitions.add(Definition(
          language: 'language',
          term: 'term',
          meanings: ['meanings'],
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
          '{"id":1,"definitions": [{"language": "language1","term": "term1","meanings": ["meaning1"],"examples": ["example1"]},{"language": "language2","term": "term2","meanings": ["meaning2"],"examples": ["example2","example3"]}]}';
      final Map<String, dynamic> decoded = jsonDecode(serializedData);

      //Act
      final entry = Entry.fromJson(decoded);

      //Assert
      expect(entry.id, 1);
      expect(entry.definitions!.length, 2);
      expect(entry.definitions![0].language, 'language1');
      expect(entry.definitions![0].term, 'term1');
      expect(entry.definitions![0].meanings, ['meaning1']);
      expect(entry.definitions![0].examples!.length, 1);
      expect(entry.definitions![0].examples![0], 'example1');
      expect(entry.definitions![1].language, 'language2');
      expect(entry.definitions![1].term, 'term2');
      expect(entry.definitions![1].meanings, ['meaning2']);
      expect(entry.definitions![1].examples!.length, 2);
      expect(entry.definitions![1].examples![0], 'example2');
      expect(entry.definitions![1].examples![1], 'example3');
    });
  });
}
