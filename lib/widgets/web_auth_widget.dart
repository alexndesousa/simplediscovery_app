import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:simplediscovery_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebAuthWidget extends StatefulWidget {
  @override
  _WebAuthWidgetState createState() => _WebAuthWidgetState();
}

class _WebAuthWidgetState extends State<WebAuthWidget> {
  WebViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        title: Text("Authenticate"),
        elevation: 7,
        backgroundColor: Colors.grey,
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (message) {
          if(message.startsWith("http://localhost:3000/")) {
            Navigator.pop(context);
            _addTokenToSF(decodeParameters(message)['access_token']);
          }
        },
        onWebViewCreated: (WebViewController c) {
          _controller = c;
        },
        initialUrl: authUrl(),
      ),
    );
  }
}

_addTokenToSF(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("auth_token", value);
}

String authUrl() {
  String clientId = "a4e259d0257745afb6d9bc995d65808d";
  String redirectUri = "http://localhost:3000/";
  String scope =
      "user-top-read user-read-private user-read-email playlist-modify-public playlist-read-private";
  String state = generateRandomString(16);
  String url = "https://accounts.spotify.com/authorize?response_type=token" +
      "&client_id=" +
      Uri.encodeFull(clientId) +
      "&scope=" +
      Uri.encodeFull(scope) +
      "&redirect_uri=" +
      Uri.encodeFull(redirectUri) +
      "&state=" +
      Uri.encodeFull(state);
  return url;
}

Map<String, String> decodeParameters(String url) {
  String parametersString = url.split("#")[1];
  Map<String, String> query = {};
  List<String> pairs = parametersString.split("&");
  for(int i=0; i<pairs.length; i++) {
    List<String> pair = pairs[i].split("=");
    query[Uri.decodeComponent(pair[0])] = Uri.decodeComponent(pair[1]);
  }
  return query;
}

Map<String, String> getAuthorizationHeader(String url) {
  Map<String, String> authInfo = decodeParameters(url);
  Map<String, String> newHeader = {
    "Authorization" : " " + authInfo['token_type'] + " " + authInfo['access_token']
  };
  return newHeader;
}
