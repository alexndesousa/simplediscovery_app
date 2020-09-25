import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:simplediscovery_app/models/playlist.dart';
import 'package:simplediscovery_app/models/song.dart';
import 'package:simplediscovery_app/services/discovery_service.dart';

class GenerateModel extends ChangeNotifier {
  final List<String> _songs = [];
  final List<String> _identifiedArtists = [];
  final List<String> _relatedArtists = [];

  final Playlist playlist;

  GenerateModel(this.playlist);

  DiscoveryService service = new DiscoveryService();

  UnmodifiableListView get songs => UnmodifiableListView(_songs);
  UnmodifiableListView get identifiedArtists =>
      UnmodifiableListView(_identifiedArtists);
  UnmodifiableListView get relatedArtists =>
      UnmodifiableListView(_relatedArtists);

  Future<void> getSimilarArtistsTopSongs() async {
    await getAllUniqueArtistsInPlaylist().then((artistIds) async {
      print("number of unique artists ${artistIds.length}");
      return await getUniqueMultipleSimilarArtists(artistIds.toList());
    }).then((similarArtistIds) async {
      print("number of similar artists ${similarArtistIds.length}");
      return await getMultipleArtistsTopSongs(similarArtistIds.toList(), "GB");
    }).then((value) {
      print("number of top songs ${value.length}");
      print(value);
    });
  }

  Future<List<String>> getMultipleArtistsTopSongs(
      artistIds, countryCode) async {
    List<String> allTracks = [];
    print("so im about to await the getMultipleArtistsTopSongs");
    List<Map<String, dynamic>> multipleArtistsTopSongs =
        await service.getMultipleArtistsTopSongs(artistIds, countryCode);
    print("made it through the getMultipleArtistsTopSongs");
    print(multipleArtistsTopSongs);
    for (final topSongs in multipleArtistsTopSongs) {
      for (final song in topSongs['tracks']) {
        allTracks.add(song['id']);
      }
    }
    _songs.addAll(allTracks);
    notifyListeners();
    return allTracks;
  }

  Future<Set<String>> getUniqueMultipleSimilarArtists(artistIds) async {
    Set<String> allArtists = {};
    Set<String> allNames = {};
    List<Map<String, dynamic>> allSimilarArtists =
        await service.getMultipleSimilarArtists(artistIds);

    print("i successfully awaited the allSimilarArtists");
    //print(allSimilarArtists);
    for (final similarArtists in allSimilarArtists) {
      for (final artists in similarArtists['artists']) {
        allArtists.add(artists['id']);
        allNames.add(artists['name']);
      }
    }
    print("got all them unique multiple similar artists");
    _relatedArtists.addAll(allNames);
    notifyListeners();
    return allArtists;
  }

  Future<Set<String>> getAllUniqueArtistsInPlaylist() async {
    Set<String> artistIds = {};
    Set<String> artistNames = {};
    await service.getAllSongsInPlaylist(playlist.id).then((rawSongs) {
      for (final song in rawSongs) {
        for (final artist in song['track']['artists']) {
          if (artist['id'] != null) {
            artistIds.add(artist['id']);
            artistNames.add(artist['name']);
          }
        }
      }
    });
    _identifiedArtists.addAll(artistNames);
    notifyListeners();
    return artistIds;
  }
}
