import 'package:flutter/material.dart';
import 'package:simplediscovery_app/models/song.dart';

class SongTile extends StatelessWidget {

  final Song song;

  SongTile(this.song);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(song.artworkUrl),
      title: Text(song.name),
      subtitle: Text(song.artist),
    );
  }
}