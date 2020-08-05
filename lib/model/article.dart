import 'package:equatable/equatable.dart';

class Article extends Equatable {
  String title;
  String imageUrl;
  String content;

  Article({this.title, this.imageUrl, this.content});

  Article.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        imageUrl = json['imageUrl'],
        content = json['content'];

  @override
  List<Object> get props => [title, imageUrl, content];
}
