class Article {
  final String? title;
  final String? imageUrl;
  final String? content;

  Article({this.title, this.imageUrl, this.content});

  Article.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        imageUrl = json['imageUrl'],
        content = json['content'];
}
