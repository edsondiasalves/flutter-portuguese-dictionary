import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../search.dart';

class SearchResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is StartedState) {
          return Expanded(
            child: TermResultList(
              entries: state.entries,
            ),
          );
        }

        if (state is FilteredResultState) {
          return Expanded(
            child: TermResultList(
              entries: state.entries,
            ),
          );
        }

        return Container();
      },
    );
  }
}
