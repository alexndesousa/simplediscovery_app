

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:simplediscovery_app/models/playlist.dart';
import 'package:simplediscovery_app/models/song.dart';
import 'package:simplediscovery_app/services/discovery_service.dart';

class PlaylistSongsModel extends ChangeNotifier {
  final Map<Playlist, List<Song>> _songs = Map();

  DiscoveryService service = new DiscoveryService();

  UnmodifiableMapView get songs => UnmodifiableMapView(_songs);

  
  Future<void> getSongsInPlaylist(Playlist playlist) async {
    await service.getSongsInPlaylist(playlist.id).then((rawSongs) async {
      List<Song> songs = [];
      for (final song in rawSongs) {
        String name = song['track']['name'];
        String id = song['track']['id'];
        String image = song['track']['album']['images'][0]['url'];
        List<String> artists = [];
        for(final artist in song['track']['artists']) {
          if(artist['name'] != null) {
            artists.add(artist['name']);
          }
        }
        songs.add(Song(id, artists.join(", "), name, image));
      }
      _songs[playlist]=songs;
      
    });
    notifyListeners();
  }
}