import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';

import 'modules/home/bloc/bloc.dart';
import 'modules/home/home.dart';
import 'modules/search/bloc/bloc.dart';

void main() => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (BuildContext context) =>
                HomeBloc()..add(HomeInitializeEvent()),
          ),
          BlocProvider<SearchBloc>(
            create: (BuildContext context) =>
                SearchBloc(definitionService: DefinitionService())
                  ..add(StartEvent()),
          ),
        ],
        child: Home(),
      ),
    );
