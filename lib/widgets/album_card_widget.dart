import 'package:flutter/material.dart';
import 'package:simplediscovery_app/widgets/song_tile_widget.dart';

class AlbumCard extends StatefulWidget {
  @override
  _AlbumCardState createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ExpansionTile(
        leading: Icon(Icons.crop_square),
        trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.crop_original),
                color: Colors.green,
                onPressed: () => print("hey"),
              ),
              Icon(Icons.keyboard_arrow_down)
            ]),
        title: Text("Album name"),
        subtitle: Text("more info about album"),
        children: [
          Container(
            height: 200,
            child: ListView(
              shrinkWrap: true,
              children: [
                SongTile(),
                SongTile(),
                SongTile(),
                SongTile(),
                SongTile(),
                SongTile(),
                SongTile(),
                SongTile(),
                SongTile(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
