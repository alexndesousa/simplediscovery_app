import 'package:flutter/material.dart';
import 'package:simplediscovery_app/widgets/custom_nav_bar.dart';

class ImportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Import",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            FlatButton(
                onPressed: () => print("attempted to import playlist"),
                child: Text("Import playlist")),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
