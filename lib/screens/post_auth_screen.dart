import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostAuthScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("you have successfully authenticated. Press one of the buttons below to get started"),
          ],
        ),
      ),
    );
  }
  
  _getTokenFromSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(key));

  }
}