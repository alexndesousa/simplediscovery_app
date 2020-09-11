import 'package:flutter/material.dart';
import 'package:simplediscovery_app/widgets/album_card_widget.dart';

class ImportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          
          children: [
            FlatButton(
                onPressed: () => print("attempted to import playlist"),
                child: Text("Import playlist")),
            AlbumCard(),
            AlbumCard(),
            AlbumCard()
          ],
        ),
      );
  }
}
