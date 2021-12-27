import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:portuguese_dictionary/model/model.dart';

class HomeService {
  final List<Article> _articles = [];

  Future<List<Article>> getHomeArticles() async {
    if (_articles.length == 0) {
      final articleFile = await rootBundle.loadString('assets/data/articles.json');
      var articleJson = jsonDecode(articleFile);
      articleJson.forEach((article) => _articles.add(Article.fromJson(article)));
    }

    return _articles;
  }
}
