import 'package:flutter/material.dart';
import 'package:tiger_vibes/models/songs-models.dart';
import 'package:tiger_vibes/screens/musicPlayer_page.dart';
import '../music_service.dart'; // Assurez-vous que le chemin d'importation est correct

class MusicListPage extends StatefulWidget {
  const MusicListPage({super.key});

  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  late Future<List<AppSongModel>> _songs;

  @override
  void initState() {
    super.initState();
    _songs = MusicService().fetchAllMusicFiles(); // Chargez toutes les musiques
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(239, 2, 8, 23),
      appBar: AppBar(
        title: const Text(
          'Chansons',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(239, 2, 8, 23),
        elevation: 4.0, // Ajoute une légère ombre
        iconTheme: const IconThemeData(
          color: Colors.orange,
        ),
      ),
      body: FutureBuilder<List<AppSongModel>>(
        future: _songs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No music files found.'));
          }

          final songs = snapshot.data!;
          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];

              return Card(
                color: const Color.fromARGB(255, 30, 41, 59),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5, // Ombre de la carte
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: const Icon(
                    Icons.music_note,
                    color: Colors.orangeAccent,
                    size: 40,
                  ),
                  title: Text(
                    song.title,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    song.artist,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayerPage(
                          songs: songs,
                          currentIndex: index,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
