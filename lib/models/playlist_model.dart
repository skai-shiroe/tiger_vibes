import 'package:tiger_vibes/models/song_model.dart';

class Playlist {
  final String title;
  final List<Song> songs;
  final String imageUrl;

  Playlist({
    required this.title,
    required this.songs,
    required this.imageUrl,
  });

  static List<Playlist> playlists = [
    Playlist(
        title: 'Hip-hop',
        songs: Song.songs,
        imageUrl: 'assets/images/hiphop.jpg'),
    Playlist(
        title: 'Rock',
        songs: Song.songs,
        imageUrl: 'assets/images/rock.jpg'),
    Playlist(
        title: 'Jazz',
        songs: Song.songs,
        imageUrl: 'assets/images/jazz.jpg'),
    Playlist(
        title: 'Pop',
        songs: Song.songs,
        imageUrl: 'assets/images/pop.png'),
    Playlist(
        title: 'Country',
        songs: Song.songs,
        imageUrl: 'assets/images/country.jpg'),
  ];
}
