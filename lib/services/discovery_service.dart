import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class DiscoveryService {
  String baseUrl = 'https://api.spotify.com/v1';

  getHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString("auth_token");
    return {"Authorization": " Bearer " + authToken};
  }

  Future<Map<String, dynamic>> getUserProfileInformation() async {
    var response = await http.get(Uri.encodeFull(baseUrl + "/me"),
        headers: await getHeader());
    //format it so only the relevant data is kept
    Map<String, dynamic> body = jsonDecode(response.body);
    //print(body);
    return body;
  }

  Future<Map<String, dynamic>> getUsersPlaylists() async {
    var response = await http.get(
        Uri.encodeFull(baseUrl + "/me/playlists?limit=50"),
        headers: await getHeader());
    Map<String, dynamic> body = jsonDecode(response.body);
    return body;
  }

  Future<Map<String, dynamic>> artistSearch(String query) async {
    String type = "artist";
    var response = await http.get(
        Uri.encodeFull(baseUrl + "/search?q=" + query + "&type=" + type),
        headers: await getHeader());
    Map<String, dynamic> body = jsonDecode(response.body);
    return body;
  }

  Future<Map<String, dynamic>> songSearch(String query) async {
    String type = "track";
    var response = await http.get(
        Uri.encodeFull(baseUrl + "/search?q=" + query + "&type=" + type),
        headers: await getHeader());
    Map<String, dynamic> body = jsonDecode(response.body);
    return body;
  }

  Future<Map<String, dynamic>> albumSearch(String query) async {
    String type = "album";
    var response = await http.get(
        Uri.encodeFull(baseUrl + "/search?q=" + query + "&type=" + type),
        headers: await getHeader());
    Map<String, dynamic> body = jsonDecode(response.body);
    return body;
  }

  Future<Map<String, dynamic>> getSimilarArtists(String artistId) async {
    var response = await http.get(
        Uri.encodeFull(baseUrl + "/artists/" + artistId + "related-artists"),
        headers: await getHeader());
    Map<String, dynamic> body = jsonDecode(response.body);
    return body;
  }

  Future<List<Map<String, dynamic>>> getMultipleSimilarArtists(
      List<String> artistIds) async {
    List<Response> responses = await Future.wait(artistIds.map((artistId) =>
        http.get(
            Uri.encodeFull(
                baseUrl + "/artists/" + artistId + "related-artists"),
            headers: getHeader())));
    List<Map<String, dynamic>> body =
        responses.map((response) => jsonDecode(response.body));
    return body;
  }
}
