import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiger_vibes/screens/lyrics_screen.dart';
import 'package:tiger_vibes/screens/playlist_screen.dart';
import 'package:tiger_vibes/screens/song_screen.dart';
import 'welcome_page.dart';

const d_red = Color(0x2ffe9717d);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tiger Vibes',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(), // welcome page here
      getPages: [
        GetPage(name: '/', page: () => const WelcomePage()),
        GetPage(name: '/song', page: () => const SongPage()),
        GetPage(name: '/playlist', page: () => const PlaylistPage()),
        GetPage(
          name: '/lyrics',
          page: () => LyricsPage(
            lyrics: Get.parameters['lyrics'] ?? '',
            songTitle: Get.parameters['songTitle'] ?? '',
            artist: Get.parameters['artist'] ?? '',
          ),
        ),
      ],
    );
  }
}
