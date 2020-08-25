import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:portuguese_dictionary/model/model.dart';

class HomeService {
  Future<List<Article>> getHomeArticles() async {
    final List<Article> articles = [];

    final news = await Firestore.instance.collection('news').getDocuments();

    news.documents.forEach((element) {
      articles.add(Article.fromJson(element.data));
    });

    return articles;
  }

  Future<void> insertArticlesFromFile() async {
    final articleFile = await rootBundle.loadString(
      'assets/data/articles.json',
    );

    List<dynamic> articlesJson = jsonDecode(articleFile);
    final news = Firestore.instance.collection('news');
    articlesJson.forEach((article) => news.add(article));
    return;
  }
}
