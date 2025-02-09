import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiger_vibes/models/song_model.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/song', arguments: song);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                    song.coverUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.37,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        song.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: Color.fromARGB(255, 255, 253, 253),
                                fontWeight: FontWeight.bold),
                      ),
                      Text(
                        song.description,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.play_circle,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
