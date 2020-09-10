import 'package:flutter/material.dart';
import 'widgets/custom_nav_bar.dart';
import 'widgets/web_auth_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = "";
  bool authenticated;

  @override
  void initState() {
    super.initState();
    authenticated = false;
    //here i can check whether or not the user is authenticated from a previous session
  }

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
      body: !authenticated ? _preAuth() : _postAuth(),
      bottomNavigationBar: CustomNavBar(),
    );
  }

  authCallback(value) => setState(() {
        _text = value;
        authenticated = true;
      });

  Widget _postAuth() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("you have successfully authenticated"),
            Text("and your auth code is: $_text")
          ],
        ),
      ),
    );
  }

  Widget _preAuth() {
    return Container(
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
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) => WebAuthWidget(
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