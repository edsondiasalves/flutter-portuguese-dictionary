class Article {
  String title;
  String imageUrl;
  String content;

  Article({this.title, this.imageUrl, this.content});

  Article.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        imageUrl = json['imageUrl'],
        content = json['content'];
}
