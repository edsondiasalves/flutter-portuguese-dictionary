import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String title;
  final String imageUrl;
  final String content;

  Article({this.title, this.imageUrl, this.content});

  Article.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        imageUrl = json['imageUrl'],
        content = json['content'];

  @override
  List<Object> get props => [title, imageUrl, content];
}
