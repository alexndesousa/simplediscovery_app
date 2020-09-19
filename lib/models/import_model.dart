import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:simplediscovery_app/models/playlist.dart';
import 'package:simplediscovery_app/models/song.dart';
import 'package:simplediscovery_app/services/discovery_service.dart';

class ImportModel extends ChangeNotifier {
  final List<Playlist> _playlists = [];

  DiscoveryService service = new DiscoveryService();

  UnmodifiableListView get playlists => UnmodifiableListView(_playlists);

  Future<void> getPlaylists() async {
    await service.getUsersPlaylists().then((rawPlaylists) {
      for (final playlist in rawPlaylists) {
        String artworkUrl = playlist['images'][0]['url'];
        String name = playlist['name'];
        String description = playlist['description'];
        String id = playlist['id'];
        int numOfTracks = playlist['tracks']['total'];
        _playlists.add(Playlist(artworkUrl, name, description, id, numOfTracks));
      }
      notifyListeners();
    });
  }

  void removePlaylist(Playlist playlist) {
    _playlists.remove(playlist);
    notifyListeners();
  }
}
