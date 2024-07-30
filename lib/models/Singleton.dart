import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class AudioPlayerSingleton {
  static final AudioPlayerSingleton _instance = AudioPlayerSingleton._internal();
  factory AudioPlayerSingleton() => _instance;
  AudioPlayerSingleton._internal();

  final AudioPlayer audioPlayer = AudioPlayer();
  late final Stream<Duration> positionStream = audioPlayer.positionStream;
  late final Stream<Duration?> durationStream = audioPlayer.durationStream;

  static AudioPlayerSingleton get instance => _instance;

  void playCurrentSong(String filePath) async {
    await audioPlayer.setFilePath(filePath);
    audioPlayer.play();
  }

  void dispose() {
    audioPlayer.dispose();
  }
}
