import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:simplediscovery_app/models/playlist.dart';
import 'package:simplediscovery_app/models/song.dart';
import 'package:simplediscovery_app/services/discovery_service.dart';

class PlaylistSongsModel extends ChangeNotifier {
  final List<Song> _songs = List();
  final Playlist playlist;

  PlaylistSongsModel(this.playlist);

  DiscoveryService service = new DiscoveryService();

  UnmodifiableListView get songs => UnmodifiableListView(_songs);

  void refresh() {
    _songs.clear();
    getSongsInPlaylist(0);
    notifyListeners();
  }

    Future<void> getSongsInPlaylist(int page) async {
    await service.getSongsInPlaylist(playlist.id, page).then((rawSongs) async {
      List<Song> songs = [];
      for (final song in rawSongs) {
        String name = song['track']['name'];
        String id = song['track']['id'];
        List<String> artists = [];
        for (final artist in song['track']['artists']) {
          if (artist['name'] != null) {
            artists.add(artist['name']);
          }
        }
        songs.add(Song(id, artists.join(", "), name));
      }
      _songs.addAll(songs);
    });
    notifyListeners();
  }

  void removeSong(int index) {
    _songs.removeAt(index);
    playlist.numberOfTracks--;
    notifyListeners();
  }

}
