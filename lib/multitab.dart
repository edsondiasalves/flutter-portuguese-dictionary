import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portuguese_dictionary/services/services.dart';

import 'bottom_bar.dart';
import 'modules/home/bloc/bloc.dart';
import 'modules/modules.dart';
import 'modules/profile/bloc/bloc.dart';
import 'modules/search/bloc/bloc.dart';

class Multitab extends StatefulWidget {
  final CollectionReference newsCollection;
  final CollectionReference entriesCollection;

  Multitab({this.newsCollection, this.entriesCollection});

  @override
  _MultitabState createState() => _MultitabState(
        newsCollection: newsCollection,
        entriesCollection: entriesCollection,
      );
}

class _MultitabState extends State<Multitab> {
  final CollectionReference newsCollection;
  final CollectionReference entriesCollection;

  static HomeBloc homeBloc;
  static SearchBloc searchBloc;
  static ProfileBloc profileBloc;

  int currentTab = 0;

  _MultitabState({this.newsCollection, this.entriesCollection}) {
    homeBloc = HomeBloc(
      homeService: HomeService(
        collection: newsCollection,
      ),
    );
    searchBloc = SearchBloc(
      definitionService: DefinitionService(
        collection: entriesCollection,
      ),
    );
    profileBloc = ProfileBloc();
  }

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
      resizeToAvoidBottomPadding: false,
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
