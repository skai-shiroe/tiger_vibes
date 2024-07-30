import 'package:just_audio/just_audio.dart';

class MusicPlayer {
  static final MusicPlayer _instance = MusicPlayer._internal();
  late AudioPlayer _audioPlayer;

  factory MusicPlayer() {
    return _instance;
  }

  MusicPlayer._internal() {
    _audioPlayer = AudioPlayer();
  }

  AudioPlayer get audioPlayer => _audioPlayer;

  Future<void> play(String path) async {
    await _audioPlayer.setFilePath(path);
    _audioPlayer.play();
  }

  void stop() {
    _audioPlayer.stop();
  }
}
