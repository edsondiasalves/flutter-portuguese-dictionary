import 'package:flutter/material.dart';

class SearchLessThanTwoCharacters extends StatelessWidget {
  const SearchLessThanTwoCharacters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            "Search term must be longer than two letters.",
          ),
        )
      ],
    );
  }
}
