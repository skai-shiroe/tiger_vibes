import 'package:on_audio_query/on_audio_query.dart';

class AppSongModel {
  final int id;
  final String title;
  final String artist;
  final String data;
  final String album;
  final int? albumId; // Propriété nullable

  AppSongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.data,
    required this.album,
    this.albumId, // Peut être null
  });

  // Méthode pour convertir un SongModel en AppSongModel
  static AppSongModel fromSongModel(SongModel songModel) {
    return AppSongModel(
      id: songModel.id,
      title: songModel.title,
      artist: songModel.artist ?? 'Unknown Artist',
      data: songModel.data,
      album: songModel.album ?? 'Unknown Album',
      albumId: songModel.albumId, // Propriété nullable
    );
  }
}
