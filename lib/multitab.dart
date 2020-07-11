import 'package:flutter/material.dart';
import 'package:portuguese_dictionary/routes.dart';

import 'bottom_bar.dart';
import 'modules/modules.dart';

class Multitab extends StatefulWidget {
  @override
  _MultitabState createState() => _MultitabState();
}

class _MultitabState extends State<Multitab> {
  int currentTab = 0;

  final navigatorPage = [Home(), Search(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _buildOffstageNavigator(0),
        _buildOffstageNavigator(1),
        _buildOffstageNavigator(2),
      ]),
      bottomNavigationBar: BottomBar(
        currentTab: currentTab,
        onTabChange: (tabItem) {
          setState(() {
            currentTab = tabItem;
          });
        },
        onReturn: () {
          Navigator.pushNamed(context, Routes.intro);
        },
      ),
    );
  }

  Widget _buildOffstageNavigator(int tabItem) {
    return Offstage(
      offstage: currentTab != tabItem,
      child: navigatorPage[tabItem],
    );
  }
}
