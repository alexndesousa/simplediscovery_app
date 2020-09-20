import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplediscovery_app/models/playlist.dart';
import 'package:simplediscovery_app/models/playlist_songs_model.dart';
import 'package:simplediscovery_app/screens/generation_screen.dart';
import 'package:simplediscovery_app/widgets/song_tile_widget.dart';

class SelectedPlaylistScreen extends StatelessWidget {
  final Playlist playlist;

  SelectedPlaylistScreen(this.playlist);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlaylistSongsModel(playlist)..getSongsInPlaylistPaginated(0),
      child: Consumer<PlaylistSongsModel>(
        builder: (context, import, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: AppBar().preferredSize,
              child: Hero(
                tag: "appbar",
                child: AppBar(
                  actions: [
                    IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => import.refresh())
                  ],
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop()),
                ),
              ),
            ),
            body: Column(
              children: [
                PlaylistSummary(playlist: playlist),
                PlaylistSongList(playlist: playlist, import: import)
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: Text("Generate"),
              backgroundColor: Colors.deepOrange[300],
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => GeneratingPlaylistScreen(playlist))),
            ),
          );
        },
      ),
    );
  }
}

class PlaylistSongList extends StatelessWidget {
  const PlaylistSongList(
      {Key key, @required this.playlist, @required this.import})
      : super(key: key);

  final Playlist playlist;
  final PlaylistSongsModel import;
  @override
  Widget build(BuildContext context) {
    return import.songs.length == 0
        ? Padding(
            padding: EdgeInsets.all(20), child: CircularProgressIndicator())
        : Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
              itemCount: import.songs.length,
              itemBuilder: (_, index) => import.songs.length - 1 == index &&
                      import.songs.length < playlist.numberOfTracks
                  ? Column(
                      children: [
                        Dismissible(
                            onDismissed: (direction) =>
                                import.removeSong(index),
                            background: Container(
                              color: Colors.red,
                            ),
                            key: Key("${import.songs[index].hashCode}"),
                            child: SongTile(import.songs[index])),
                        FlatButton(
                            onPressed: () {
                              import.getSongsInPlaylistPaginated(
                                  import.songs.length ~/ 100);
                              print("item count ${import.songs.length}");
                            },
                            child: Text("load more")),
                      ],
                    )
                  : Dismissible(
                      onDismissed: (direction) => import.removeSong(index),
                      background: Container(
                        color: Colors.red,
                      ),
                      key: Key("${import.songs[index].hashCode}"),
                      child: SongTile(import.songs[index])),
            ),
          );
  }
}

class PlaylistSummary extends StatelessWidget {
  const PlaylistSummary({
    Key key,
    @required this.playlist,
  }) : super(key: key);

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Material(

      elevation: 7,
          child: Padding(
            padding: EdgeInsets.all(10),
                      child: Row(
        children: [
            Flexible(
              flex: 1,
              child: Hero(
                tag: "playlist_image${playlist.hashCode}",
                child: Image.network(
                  playlist.artworkUrl,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Center(
                              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: "playlist_name${playlist.hashCode}",
                      child: Material(
                        child: Text(playlist.name),
                        textStyle: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                    Hero(
                      tag: "playlist_description${playlist.hashCode}",
                      child: Material(child: Text(playlist.description)),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
          ),
    );
  }
}
