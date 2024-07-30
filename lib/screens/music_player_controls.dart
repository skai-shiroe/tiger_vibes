import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tiger_vibes/models/songs-models.dart';
import 'package:tiger_vibes/widgets/seekbar.dart';

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
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                color: Colors.white,
                iconSize: 64.0,
                onPressed: audioPlayer.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                color: Colors.white,
                iconSize: 64.0,
                onPressed: audioPlayer.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                color: Colors.white,
                iconSize: 64.0,
                onPressed: () => audioPlayer.seek(Duration.zero),
              );
            }
          },
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
