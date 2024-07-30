import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
                iconSize: 64.0,
                color: Colors.white,
                onPressed: audioPlayer.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                color: Colors.white,
                onPressed: audioPlayer.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                color: Colors.white,
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
