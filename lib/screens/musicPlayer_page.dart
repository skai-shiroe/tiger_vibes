import 'package:flutter/material.dart';
import 'package:tiger_vibes/models/songs-models.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:tiger_vibes/screens/music_player.dart';
import 'package:tiger_vibes/screens/music_player_controls.dart';
import 'package:tiger_vibes/widgets/seekbar.dart';

class MusicPlayerPage extends StatefulWidget {
  final List<AppSongModel> songs;
  final int currentIndex;

  const MusicPlayerPage({
    Key? key,
    required this.songs,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  late int _currentIndex;
  late List<AppSongModel> _songs;
  late MusicPlayer _musicPlayer;

  @override
  void initState() {
    super.initState();
    _songs = widget.songs;
    _currentIndex = widget.currentIndex;
    _musicPlayer = MusicPlayer(); // Singleton instance
    _playCurrentSong();
  }

  void _playCurrentSong() async {
    final song = _songs[_currentIndex];
    await _musicPlayer.audioPlayer.setFilePath(song.data);
    _musicPlayer.audioPlayer.play();
  }

  void _playNext() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _songs.length;
      _playCurrentSong();
    });
  }

  void _playPrevious() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _songs.length) % _songs.length;
      _playCurrentSong();
    });
  }

  Stream<SeekBarData> get seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        _musicPlayer.audioPlayer.positionStream,
        _musicPlayer.audioPlayer.durationStream,
        (position, duration) =>
            SeekBarData(position, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    final song = _songs[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF1E293B),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cover.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const BackgroundFilter(),
          MusicPlayerControls(
            song: song, 
            audioPlayer: _musicPlayer.audioPlayer,
            seekBarDataStream: seekBarDataStream,
            onNext: _playNext,
            onPrevious: _playPrevious,
          ),
        ],
      ),
    );
  }
}

class BackgroundFilter extends StatelessWidget {
  const BackgroundFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.5),
            Colors.black.withOpacity(0.0),
          ],
          stops: const [0.0, 0.4, 0.6],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color(0xFF020817),
            ],
          ),
        ),
      ),
    );
  }
}
