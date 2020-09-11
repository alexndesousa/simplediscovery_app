import 'package:flutter/material.dart';

class ImportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            FlatButton(
                onPressed: () => print("attempted to import playlist"),
                child: Text("Import playlist")),
          ],
        ),
      );
  }
}
