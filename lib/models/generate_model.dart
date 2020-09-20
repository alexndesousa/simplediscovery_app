import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:simplediscovery_app/models/playlist.dart';
import 'package:simplediscovery_app/models/song.dart';
import 'package:simplediscovery_app/services/discovery_service.dart';

class GenerateModel extends ChangeNotifier {
  final List<String> _songs = [];

  final Playlist playlist;

  GenerateModel(this.playlist);

  DiscoveryService service = new DiscoveryService();

  UnmodifiableListView get songs => UnmodifiableListView(_songs);

  Future<void> getSimilarArtistsTopSongs() async {
    await getAllUniqueArtistsInPlaylist().then((artistIds) async {
      return await getUniqueMultipleSimilarArtists(artistIds.toList());
    }).then((similarArtistIds) async {
      return await getMultipleArtistsTopSongs(similarArtistIds.toList(), "GB");
    }).then((value) {
      print("got all of the songs $value");
      _songs.addAll(value);
    });
  }

  Future<List<String>> getMultipleArtistsTopSongs(
      artistIds, countryCode) async {
    List<String> allTracks = [];
    print("so im about to await the getMultipleArtistsTopSongs");
    List<Map<String, dynamic>> multipleArtistsTopSongs = await service
        .getMultipleArtistsTopSongs(artistIds, countryCode);
    print("made it through the getMultipleArtistsTopSongs");
    print(multipleArtistsTopSongs);
      for (final topSongs in multipleArtistsTopSongs) {
        for (final song in topSongs['tracks']) {
          allTracks.add(song['id']);
        }
      }
    
    return allTracks;
  }

  Future<Set<String>> getUniqueMultipleSimilarArtists(artistIds) async {
    Set<String> allArtists = {};
    List<Map<String, dynamic>> allSimilarArtists =
        await service.getMultipleSimilarArtists(artistIds);

    print("i successfully awaited the allSimilarArtists");
    print(allSimilarArtists);
    for (final similarArtists in allSimilarArtists) {
      for (final artists in similarArtists['artists']) {
        allArtists.add(artists['id']);
      }
    }
    // await service.getMultipleSimilarArtists(artistIds).then((allSimilarArtists) {
    //   for(final similarArtists in allSimilarArtists) {
    //     for(final artists in similarArtists['artists']) {
    //       allArtists.add(artists['id']);
    //     }
    //   }
    // });
    print("got all them unique multiple similar artists");
    return allArtists;
  }

  Future<Set<String>> getAllUniqueArtistsInPlaylist() async {
    Set<String> artists = {};
    await service.getAllSongsInPlaylist(playlist.id).then((rawSongs) {
      for (final song in rawSongs) {
        for (final artist in song['track']['artists']) {
          if (artist['id'] != null) {
            artists.add(artist['id']);
          }
        }
      }
    });
    print("got you all your unique artists in the playlist");
    return artists;
  }
}
