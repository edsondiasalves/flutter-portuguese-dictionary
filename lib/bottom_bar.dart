import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int? currentTab;
  final ValueChanged<int>? onTabChange;

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
        onTabChange!(index);
      },
    );
  }

  BottomNavigationBarItem _buildTab(String tabName, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.blue,
      ),
      label: tabName,
    );
  }
}
