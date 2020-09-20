import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplediscovery_app/models/import_model.dart';
import 'package:simplediscovery_app/models/playlist.dart';
import 'package:simplediscovery_app/models/playlist_songs_model.dart';
import 'package:simplediscovery_app/screens/selected_playlist_screen.dart';
import 'package:simplediscovery_app/widgets/song_tile_widget.dart';

class AlbumCard extends StatelessWidget {
  final Playlist playlist;

  AlbumCard(this.playlist);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Hero(
          tag: "playlist_image${playlist.hashCode}",
          child: Image.network(playlist.artworkUrl),
        ),
        trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_forward),
                color: Colors.green,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SelectedPlaylistScreen(playlist)))
              ),
            ]),
        title: Hero(
          tag: "playlist_name${playlist.hashCode}",
          child: Material(child: Text(playlist.name)),
        ),
        subtitle: Hero(
          tag: "playlist_description${playlist.hashCode}",
          //needs to be wrapped in material otherwise you get a visual bug when hero is in flight
          child: Material(child: Text(playlist.description)),
        ),

        // children: [
        //   Container(
        //     height: 200,
        //     child: ChangeNotifierProvider(
        //       create: (context) =>
        //           PlaylistSongsModel()..getSongsInPlaylist(playlist),
        //       child: Consumer<PlaylistSongsModel>(
        //         builder: (context, import, child) {
        //           //come up with a way to remove logic from below
        //           return import.songs[playlist] == null
        //               ? Text("loading")
        //               : ListView.builder(
        //                   itemCount: import.songs[playlist].length,
        //                   itemBuilder: (_, index) =>
        //                       SongTile(import.songs[playlist][index]),
        //                 );
        //         },
        //       ),
        //     ),
        //   )
        // ],
      ),
    );
  }
}
