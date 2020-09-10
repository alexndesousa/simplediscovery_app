import 'package:flutter/material.dart';
import 'package:simplediscovery_app/screens/auth_screen.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "simple discovery",
      theme: ThemeData(
        primaryColor: Colors.green[200],
      ),
      home: HomePage(),
      routes: {
        '/auth': (context) => AuthScreen()
      },
    );
  }
}