import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplediscovery_app/models/generate_model.dart';
import 'package:simplediscovery_app/models/playlist.dart';

class GeneratingPlaylistScreen extends StatelessWidget {
  final Playlist playlist;
  GeneratingPlaylistScreen(this.playlist);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GenerateModel(playlist)..getSimilarArtistsTopSongs(),
      child: Consumer<GenerateModel>(builder: (context, import, child) {
        return Container(
          child: Stack(
            children: [
              Container(
                child: CircularProgressIndicator(),
                color: Colors.orange.withOpacity(0.7),
              ),
              Text(import.songs.toString())
            ],
          ),
        );
      }),
    );
  }
}
