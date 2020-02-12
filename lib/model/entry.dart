import 'package:portuguese_dictionary/model/definition.dart';

class Entry {
  Entry({this.id, this.definitions});

  Entry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    definitions = List<Definition>();

    json['definitions'].forEach((value) {
      definitions.add(Definition.fromJson(value));
    });
  }

  int id;
  List<Definition> definitions;
}
