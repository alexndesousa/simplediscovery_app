import 'package:flutter/material.dart';
import 'package:simplediscovery_app/screens/import_screen.dart';
import 'widgets/custom_nav_bar.dart';
import 'screens/post_auth_screen.dart';
import 'screens/pre_auth_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool authenticated;
  int currentIndex;
  List<Widget> children;

  @override
  void initState() {
    super.initState();
    authenticated = false;
    currentIndex = 0;
    //here i can check whether or not the user is authenticated from a previous session
    print("in initstate");
    children = [
      PostAuthScreen(),
      ImportScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "simple discovery",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 7.0,
      ),
      body: children[currentIndex],
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        navigationTapped: _navigationTapped,
      ),
    );
  }

  void _navigationTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
