import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/model/model.dart';

class EntryDetails extends StatelessWidget {
  final Entry entry;
  final VoidCallback onReturn;

  const EntryDetails({
    Key key,
    @required this.entry,
    this.onReturn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          EntryCard(definition: entry.definitions[0]),
          EntryCard(definition: entry.definitions[1]),
          InkWell(
            onTap: onReturn,
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.keyboard_arrow_left, color: Colors.black),
                  Text(
                    'Back',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EntryCard extends StatelessWidget {
  const EntryCard({
    Key key,
    @required this.definition,
  }) : super(key: key);

  final Definition definition;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints:
            BoxConstraints(minWidth: 700, maxWidth: 700, minHeight: 50),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTerm(),
              _buildMeaningsList(),
              _buildExamplesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTerm() {
    return Center(
      child: Text(
        '${definition.language?.toUpperCase()} : ${definition.term}',
        style: titleStyle,
      ),
    );
  }

  Widget _buildMeaningsList() {
    if (definition.meanings == null || definition.meanings.length == 0)
      return SizedBox();

    final List<Widget> meanings = [];
    int index = 0;
    definition.meanings.forEach((f) {
      return meanings.add(
        Align(
          alignment: Alignment.bottomLeft,
          child: Text('${++index} - $f'),
        ),
      );
    });

    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7),
            child: Text('Significado:'),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: meanings,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExamplesList() {
    if (definition.examples == null || definition.examples.length == 0)
      return SizedBox();

    final List<Widget> examples = [];
    int index = 0;
    definition.examples.forEach((f) {
      return examples.add(
        Align(
          alignment: Alignment.bottomLeft,
          child: Text('${++index} - $f'),
        ),
      );
    });

    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7),
            child: Text('Exemplo:'),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: examples,
            ),
          ),
        ),
      ],
    );
  }
}

const titleStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
