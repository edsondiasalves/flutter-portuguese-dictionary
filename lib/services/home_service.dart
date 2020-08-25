import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:portuguese_dictionary/model/model.dart';

class HomeService {
  final CollectionReference collection;

  HomeService({this.collection});

  Future<List<Article>> getHomeArticles() async {
    final List<Article> articles = [];

    final news = await collection.getDocuments();

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
    final news = collection;
    articlesJson.forEach((article) => news.add(article));
    return;
  }
}
