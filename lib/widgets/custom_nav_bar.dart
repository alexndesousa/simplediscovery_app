import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  int currentIndex;
  Function navigationTapped;

  CustomNavBar({@required this.currentIndex, @required this.navigationTapped});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: BottomNavigationBar(
            onTap: navigationTapped,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.import_export), title: Text("Import")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Search")),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 12.0,
                backgroundColor: Colors.grey,
              ),
              title: Text("Profile")),
        ]));
  }
}
