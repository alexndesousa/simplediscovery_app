import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplediscovery_app/models/import_model.dart';
import 'package:simplediscovery_app/models/playlist.dart';
import 'package:simplediscovery_app/widgets/album_card_widget.dart';

class ImportScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {    
    return Container(
      child: Consumer<ImportModel>(
        builder: (context, import, child) {
          return ListView.builder(
            itemCount: import.playlists.length,
            itemBuilder: (_, index) => AlbumCard(import.playlists[index]),
          );
        },
      ),
    );
  }
}
