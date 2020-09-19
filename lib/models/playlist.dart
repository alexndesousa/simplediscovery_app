
class Playlist {
  final String artworkUrl;
  final String name;
  final String description;
  final String id;
  int numberOfTracks;

  Playlist(this.artworkUrl, this.name, this.description, this.id, this.numberOfTracks);

  //consider overiding hashCode and the == operator
}