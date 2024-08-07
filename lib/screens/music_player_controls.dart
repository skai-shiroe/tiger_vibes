import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tiger_vibes/genius_service.dart';
import 'package:tiger_vibes/models/songs-models.dart';
import 'package:tiger_vibes/screens/musicplaybutton.dart';
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
            song: song, 
          ),
        ],
      ),
    );
  }
}
