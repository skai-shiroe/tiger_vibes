import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tiger_vibes/genius_service.dart';
import 'package:tiger_vibes/models/song_model.dart';
import 'package:tiger_vibes/screens/lyrics_screen.dart';


class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    Key? key,
    required this.audioPlayer,
    required this.onNext,
    required this.onPrevious,
    required this.song,
  }) : super(key: key);

  final AudioPlayer audioPlayer;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final Song song;

  void _showLyrics(BuildContext context) async {
  try {
    final lyrics = await GeniusService.fetchLyrics(song.title, song.artist);
    Get.to(() => LyricsPage(
      lyrics: lyrics ?? 'Paroles non trouvées',
      songTitle: song.title,
      artist: song.artist,
    ));
  } catch (e) {
    print('Error fetching lyrics: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 35,
          onPressed: () {},
          icon: const Icon(
            Icons.favorite,
            color: Colors.white,
          ),
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, snapshot) {
            return IconButton(
              onPressed: audioPlayer.hasPrevious ? onPrevious : null,
              iconSize: 35,
              icon: const Icon(
                Icons.skip_previous,
                color: Colors.white,
              ),
            );
          },
        ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data;
              final processingState = playerState!.processingState;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  width: 64.0,
                  height: 64.0,
                  margin: const EdgeInsets.all(10.0),
                  child: const CircularProgressIndicator(),
                );
              } else if (!audioPlayer.playing) {
                return IconButton(
                  onPressed: audioPlayer.play,
                  iconSize: 70,
                  icon: const Icon(
                    Icons.play_circle,
                    color: Colors.white,
                  ),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  onPressed: audioPlayer.pause,
                  iconSize: 70,
                  icon: const Icon(
                    Icons.pause_circle,
                    color: Colors.white,
                  ),
                );
              } else {
                return IconButton(
                  onPressed: () => audioPlayer.seek(Duration.zero),
                  iconSize: 70,
                  icon: const Icon(
                    Icons.replay_circle_filled_outlined,
                    color: Colors.white,
                  ),
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: audioPlayer.sequenceStateStream,
          builder: (context, snapshot) {
            return IconButton(
              onPressed: audioPlayer.hasNext ? onNext : null,
              iconSize: 35,
              icon: const Icon(
                Icons.skip_next,
                color: Colors.white,
              ),
            );
          },
        ),
        IconButton(
          iconSize: 35,
          onPressed: () => _showLyrics(context),
          icon: const Icon(
            Icons.lyrics,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
