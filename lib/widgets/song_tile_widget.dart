import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.crop_square),
      title: Text("song name"),
    );
  }
}