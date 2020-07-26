class Definition {
  String language;
  String term;
  List<String> meanings;
  List<String> examples;

  Definition({this.language, this.term, this.meanings, this.examples});

  Definition.fromJson(Map<String, dynamic> json)
      : language = json['language'],
        term = json['term'],
        meanings = List<String>.from(json['meanings']),
        examples = List<String>.from(json['examples']);
}
