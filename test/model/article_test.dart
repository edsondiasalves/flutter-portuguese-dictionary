import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/model/article.dart';

void main() {
  group('Article Model', () {
    test('default values should be null', () {
      //Atc
      final definition = Article();

      //Assert
      expect(definition.imageUrl, null);
      expect(definition.title, null);
      expect(definition.content, null);
    });

    test('initialized values matches', () {
      //Arrange
      final imageUrl = 'imageUrl';
      final title = 'title';
      final content = 'content';

      //Atc
      final article = Article(
        imageUrl: imageUrl,
        title: title,
        content: content,
      );

      //Assert
      expect(article.imageUrl, imageUrl);
      expect(article.title, title);
      expect(article.content, content);
    });

    test('should deserialize correctly', () {
      //Arrange
      final serializedData =
          "{\n \"imageUrl\": \"imageUrl\",\n \"title\": \"title\",\n \"content\": \"content\"\n }";

      final Map<String, dynamic> decoded = jsonDecode(serializedData);

      //Act
      final article = Article.fromJson(decoded);

      //Assert
      expect(article.imageUrl, 'imageUrl');
      expect(article.title, 'title');
      expect(article.content, 'content');
    });
  });
}
