import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "simple discovery",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 7.0,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              FlatButton(
                onPressed: () => Navigator.push(context, _createRoute()),
                child: Text("auth"),
              ),
              Text(_text)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton( highlightColor: Colors.red, icon: Icon(Icons.home), onPressed: () => print("home")),
            IconButton(icon: Icon(Icons.import_export), onPressed: () => print("import pressed")),
            IconButton(icon: Icon(Icons.search), onPressed: () => print("search pressed")),
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
      ),
    );
  }

  authCallback(value) => setState(() => _text = value);

  Route _createRoute() {
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) => AuthScreen(
              callback: authCallback,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0, 1);
          var end = Offset.zero;
          var curve = Curves.linear;

          var tween = Tween<Offset>(begin: begin, end: end)
              .chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
