class Definition {
  String language;
  String term;
  String meaning;
  List<String> examples;

  Definition({this.language, this.term, this.meaning, this.examples});

  Definition.fromJson(Map<String, dynamic> json)
      : language = json['language'],
        term = json['term'],
        meaning = json['meaning'],
        examples = List<String>.from(json['examples']);
}
