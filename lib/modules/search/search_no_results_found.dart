import 'package:flutter/material.dart';

class SearchNoResultsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            "No results found.",
          ),
        )
      ],
    );
  }
}
