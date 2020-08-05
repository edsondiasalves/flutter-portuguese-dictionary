import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';
import 'package:portuguese_dictionary/services/home_service.dart';

import 'bottom_bar.dart';
import 'modules/home/bloc/bloc.dart';
import 'modules/modules.dart';
import 'modules/profile/bloc/bloc.dart';
import 'modules/search/bloc/bloc.dart';

class Multitab extends StatefulWidget {
  @override
  _MultitabState createState() => _MultitabState();
}

class _MultitabState extends State<Multitab> {
  static HomeBloc homeBloc = HomeBloc(homeService: HomeService());
  static SearchBloc searchBloc =
      SearchBloc(definitionService: DefinitionService());
  static ProfileBloc profileBloc = ProfileBloc();
  int currentTab = 0;

  final navigatorPage = [
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (BuildContext context) =>
              homeBloc..add(HomeInitializeEvent()),
        ),
      ],
      child: Home(Key('multitab_home')),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => searchBloc..add(StartEvent()),
        ),
      ],
      child: Search(Key('multitab_search')),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) =>
              profileBloc..add(ProfileInitializeEvent()),
        ),
      ],
      child: Profile(Key('multitab_profile')),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _buildOffstageNavigator(0, 'offstage0'),
        _buildOffstageNavigator(1, 'offstage1'),
        _buildOffstageNavigator(2, 'offstage2'),
      ]),
      bottomNavigationBar: BottomBar(
        currentTab: currentTab,
        onTabChange: (tabItem) {
          setState(() {
            currentTab = tabItem;
          });
        },
      ),
    );
  }

  Widget _buildOffstageNavigator(int tabItem, keyName) {
    return Offstage(
      key: Key(keyName),
      offstage: currentTab != tabItem,
      child: navigatorPage[tabItem],
    );
  }
}
