import 'package:flutter/material.dart';
import 'package:simplediscovery_app/screens/import_screen.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              highlightColor: Colors.red,
              icon: Icon(Icons.home),
              onPressed: () => print("home")),
          IconButton(
              icon: Icon(Icons.import_export),
              onPressed: () => Navigator.push(context, _createNoTransitionRoute(ImportScreen()))),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => print("search pressed")),
          IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
              ),
              onPressed: () => print("profile pressed"))
        ],
      ),
    );
  }

  Route _createNoTransitionRoute(Widget screen) {
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 0),
        pageBuilder: (context, animation, secondaryAnimation) =>
            screen);
  }
}
