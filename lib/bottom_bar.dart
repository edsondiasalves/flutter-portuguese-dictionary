import 'package:flutter/material.dart';

enum TabItem {
  red,
  green,
  blue,
}

Map<TabItem, String> tabName = {
  TabItem.red: 'red',
  TabItem.green: 'green',
  TabItem.blue: 'blue',
};

Map<TabItem, MaterialColor> tabColors = {
  TabItem.red: Colors.red,
  TabItem.green: Colors.green,
  TabItem.blue: Colors.blue,
};

class BottomBar extends StatelessWidget {
  final int currentTab;
  final ValueChanged<int> onTabChange;

  const BottomBar({this.currentTab, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildTab('Home', Icons.home),
        _buildTab('Search', Icons.search),
        _buildTab('Profile', Icons.person),
      ],
      onTap: (index) {
        onTabChange(index);
      },
    );
  }

  BottomNavigationBarItem _buildTab(String tabName, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.blue,
      ),
      title: Text(
        tabName,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
