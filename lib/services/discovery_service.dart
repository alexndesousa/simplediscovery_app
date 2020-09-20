import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


class DiscoveryService {
  String baseUrl = 'https://api.spotify.com/v1';

  bool isLocked = false;

  final responseCompleter = Completer<Response>();

  Dio dio = Dio();

  DiscoveryService() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        return options;
      },
      onResponse: (Response response) async {
        return response;
      },
      onError: (DioError e) async {
        print("error code: ${e.response.statusCode}");
        print("path: ${e.request.path}");
        //isLocked = true;
        
        if(e.response != null && e.response.statusCode == 429) {
          dio.interceptors.requestLock.lock();
          await Future.delayed(Duration(seconds: int.parse(e.response.headers['Retry-After'][0])));
          responseCompleter.complete(dio.get(e.request.path, options: Options(headers: e.request.headers)));
          dio.interceptors.requestLock.unlock();
          return responseCompleter.future;
        }
        //await sleepRequest(int.parse(e.response.headers['Retry-After'][0]), e.request.path, e.request.headers);
        return e;
        //isLocked = false;
        
      }
    ));
  }

  getHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("auth_token");
    return {"Authorization": " Bearer " + authToken};
  }

  Future<Map<String, dynamic>> getUserProfileInformation() async {
    var response = await dio.get(Uri.encodeFull(baseUrl + "/me"),
        options: Options(headers: await getHeader()));
    //format it so only the relevant data is kept
    //print(response.data);
    Map<String, dynamic> body = response.data;
    //print("boooody $body");
    return body;
  }

  Future<List<dynamic>> getUsersPlaylists() async {
    var response = await dio.get(
        Uri.encodeFull(baseUrl + "/me/playlists?limit=50"),
        options: Options(headers: await getHeader()));
    Map<String, dynamic> body = response.data;
    String next = body['next'];
    if (next == null) {
      return body['items'];
    }
    //the following fetches the remaining user playlists if they have more than 50
    List<dynamic> items = body['items'];
    while (next != null) {
      response =
          await dio.get(Uri.encodeFull(next), options: Options(headers: await getHeader()));
      body = response.data;
      items.addAll(body['items']);
      next = body['next'];
    }
    return items;
  }

  Future<List<dynamic>> getAllSongsInPlaylist(String id) async {
    List<dynamic> allTracks = [];
    int offset = 0;
    while (true) {
      var response = await dio.get(
          Uri.encodeFull("$baseUrl/playlists/$id/tracks?offset=$offset"),
          options: Options(headers: await getHeader()));
      Map<String, dynamic> body = response.data;
      allTracks.addAll(body['items']);
      if (body['next'] == null) {
        break;
      }
      offset += 100;
    }
    return allTracks;
  }

  Future<List<dynamic>> getSongsInPlaylistPaginated(String id, int page) async {
    var response = await dio.get(
        Uri.encodeFull("$baseUrl/playlists/$id/tracks?offset=${page * 100}"),options: Options(headers: await getHeader()));
    Map<String, dynamic> body = response.data;
    return body['items'];
  }

  Future<Map<String, dynamic>> artistSearch(String query) async {
    String type = "artist";
    var response = await dio.get(
        Uri.encodeFull(baseUrl + "/search?q=$query&type=$type"),options: Options(headers: await getHeader()));
    Map<String, dynamic> body = response.data;
    return body;
  }

  Future<Map<String, dynamic>> songSearch(String query) async {
    String type = "track";
    var response = await dio.get(
        Uri.encodeFull(baseUrl + "/search?q=$query&type=$type"),options: Options(headers: await getHeader()));
    Map<String, dynamic> body = response.data;
    return body;
  }

  Future<Map<String, dynamic>> albumSearch(String query) async {
    String type = "album";
    var response = await dio.get(
        Uri.encodeFull(baseUrl + "/search?q=$query&type=$type"),options: Options(headers: await getHeader()));
    Map<String, dynamic> body = response.data;
    return body;
  }

  Future<Map<String, dynamic>> getSimilarArtists(String artistId) async {
    var response = await dio.get(
        Uri.encodeFull(baseUrl + "/artists/" + artistId + "related-artists"),options: Options(headers: await getHeader()));
    Map<String, dynamic> body = response.data;
    return body;
  }

  Future<List<Map<String, dynamic>>> getMultipleSimilarArtists(
      List<String> artistIds) async {
    var header = await getHeader();
    //print("header");
    var responses = await Future.wait(artistIds.map((artistId) => dio.get(
        Uri.encodeFull(baseUrl + "/artists/" + artistId + "/related-artists"),options: Options(headers: header))));

    List<Map<String, dynamic>> body = [];
    for (final response in responses) {
      body.add(response.data);
    }
    //responses.map((response) => response.data);
    return body;
  }

  Future<List<Map<String, dynamic>>> getMultipleArtistsTopSongs(
      List<String> artistIds, String country) async {
    var header = await getHeader();
    //print("starting the wait");
    //await Future.delayed(Duration(seconds: 5));
    //print("finished the wait");
    var responses = await Future.wait(artistIds.map((artistId) => dio.get(
        Uri.encodeFull("$baseUrl/artists/$artistId/top-tracks?country=GB"),
        options: Options(headers: header))));
    //print("got alla them responses");
    //print(responses);
    List<Map<String, dynamic>> body = [];
    for (final response in responses) {
      body.add(response.data);
      //print(response.data);
    }
    return body;
  }
}
