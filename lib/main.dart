import 'package:flutter/material.dart';
import 'package:simplediscovery_app/screens/import_screen.dart';
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
        primaryColor: Colors.deepOrange[200],
      ),
      home: HomePage(),
    );
  }
}