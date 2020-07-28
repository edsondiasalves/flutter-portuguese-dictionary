import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/model/definition.dart';

void main() {
  group('Definition Model', () {
    test('default values should be null', () {
      //Atc
      final definition = Definition();

      //Assert
      expect(definition.language, null);
      expect(definition.term, null);
      expect(definition.meanings, null);
      expect(definition.examples, null);
    });

    test('initialized values matches', () {
      //Arrange
      final language = 'language';
      final term = 'term';
      final meanings = ['meaning'];
      final examples = ['example1'];

      //Atc
      final definition = Definition(
          language: language,
          term: term,
          meanings: meanings,
          examples: examples);

      //Assert
      expect(definition.language, language);
      expect(definition.term, term);
      expect(definition.meanings, meanings);
      expect(definition.examples, examples);
    });

    test('should deserialize correctly', () {
      //Arrange
      final serializedData =
          "{\n \"language\": \"language1\",\n \"term\": \"term1\",\n \"meanings\": [\n \"meaning1\"\n ],\n \"examples\": [\n \"example1\"\n ]\n }";

      final Map<String, dynamic> decoded = jsonDecode(serializedData);

      //Act
      final definition = Definition.fromJson(decoded);

      //Assert
      expect(definition.language, 'language1');
      expect(definition.term, 'term1');
      expect(definition.meanings, ['meaning1']);
      expect(definition.examples, ['example1']);
    });
  });
}
