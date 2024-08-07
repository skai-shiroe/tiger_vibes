import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tiger_vibes/genius_service.dart';
import 'package:tiger_vibes/models/songs-models.dart';

class MusicPlayerButtons extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final AppSongModel song;

  const MusicPlayerButtons({
    Key? key,
    required this.audioPlayer,
    required this.onNext,
    required this.onPrevious,
    required this.song,
  }) : super(key: key);

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
            final playing = playerState?.playing ?? false;
            final icon = playing ? Icons.pause : Icons.play_arrow;

            return IconButton(
              icon: Icon(icon),
              color: Colors.white,
              onPressed: () {
                if (playing) {
                  audioPlayer.pause();
                } else {
                  audioPlayer.play();
                }
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          color: Colors.white,
          onPressed: onNext,
        ),
        IconButton(
          icon: const Icon(Icons.music_note),
          color: Colors.white,
          onPressed: () async {
            if (song.artist.toLowerCase() == '<unknown>') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Paroles non trouvées.')),
              );
              return;
            }

            // Code pour récupérer et afficher les paroles
            final lyrics =
                await GeniusService.fetchLyrics(song.title, song.artist);
            if (lyrics != null) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Paroles de ${song.title}'),
                  content: SingleChildScrollView(child: Text(lyrics)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Fermer'),
                    ),
                  ],
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Paroles non trouvées.')),
              );
            }
          },
        ),
      ],
    );
  }
}
