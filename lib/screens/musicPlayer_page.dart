import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tiger_vibes/models/songs-models.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
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
  late AudioPlayer _audioPlayer;
  late int _currentIndex;
  late List<AppSongModel> _songs;

  @override
  void initState() {
    super.initState();
    _songs = widget.songs;
    _currentIndex = widget.currentIndex;
    _audioPlayer = AudioPlayer();
    _playCurrentSong();
  }

  void _playCurrentSong() async {
    final song = _songs[_currentIndex];
    await _audioPlayer.setFilePath(song.data);
    _audioPlayer.play();
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

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        _audioPlayer.positionStream,
        _audioPlayer.durationStream,
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
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const BackgroundFilter(),
          MusicPlayerControls(
            song: song,
            audioPlayer: _audioPlayer,
            seekBarDataStream: seekBarDataStream,
            onNext: _playNext,
            onPrevious: _playPrevious,
          ),
        ],
      ),
    );
  }
}

class MusicPlayerControls extends StatelessWidget {
  const MusicPlayerControls({
    Key? key,
    required this.song,
    required this.audioPlayer,
    required this.seekBarDataStream,
    required this.onNext,
    required this.onPrevious,
  }) : super(key: key);

  final AppSongModel song;
  final AudioPlayer audioPlayer;
  final Stream<SeekBarData> seekBarDataStream;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            song.artist,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          StreamBuilder<SeekBarData>(
            stream: seekBarDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                position: positionData?.position ?? Duration.zero,
                duration: positionData?.duration ?? Duration.zero,
                onChanged: audioPlayer.seek,
                onChangedEnd: audioPlayer.seek,
              );
            },
          ),
          MusicPlayerButtons(
            audioPlayer: audioPlayer,
            onNext: onNext,
            onPrevious: onPrevious,
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

class MusicPlayerButtons extends StatelessWidget {
  const MusicPlayerButtons({
    Key? key,
    required this.audioPlayer,
    required this.onNext,
    required this.onPrevious,
  }) : super(key: key);

  final AudioPlayer audioPlayer;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          color: Colors.white,
          onPressed: onPrevious,
        ),
        IconButton(
          icon: const Icon(Icons.play_arrow),
          color: Colors.white,
          onPressed: () => audioPlayer.play(),
        ),
        IconButton(
          icon: const Icon(Icons.pause),
          color: Colors.white,
          onPressed: () => audioPlayer.pause(),
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.white,
          onPressed: () => audioPlayer.stop(),
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          color: Colors.white,
          onPressed: onNext,
        ),
      ],
    );
  }
}
