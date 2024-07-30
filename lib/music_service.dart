import 'package:on_audio_query/on_audio_query.dart';
import 'package:tiger_vibes/models/songs-models.dart';

class MusicService {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<AppSongModel>> fetchAllMusicFiles() async {
    // Assurez-vous que les permissions sont accordées
    final permissions = await _audioQuery.permissionsStatus();
    if (!permissions) {
      await _audioQuery.permissionsRequest();
    }

    // Récupère les chansons
    List<SongModel> songs = await _audioQuery.querySongs();

    // Convertit en AppSongModel
    return songs.map((song) => AppSongModel(
      id: song.id,
      title: song.title,
      artist: song.artist ?? 'Unknown Artist',
      data: song.data,
      album: song.album ?? 'Unknown Album',
      albumId: song.albumId ?? 0,
    )).toList();
  }
}
