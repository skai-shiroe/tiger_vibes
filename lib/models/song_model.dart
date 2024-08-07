class Song {
  final String title;
  final String artist;
  final String description;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
    required this.artist,
    required this.description,
    required this.url,
    required this.coverUrl,
  });

  static List<Song> songs = [
   
 
    Song(
      title: 'Bolingo',
      artist: 'Franglish',
      description: 'Bolingo',
      url: 'assets/music/bolingo.mp3',
      coverUrl: 'assets/images/bolingo.jpg',
    ),
    Song(
      title: 'Position',
      artist: 'Franglish',
      description: 'Position',
      url: 'assets/music/position.mp3',
      coverUrl: 'assets/images/position.png',
    ),

    Song(
      title: 'Fast',
      artist: 'Juice WRLD',
      description: 'fast',
      url: 'assets/music/fast.mp3',
      coverUrl: 'assets/images/fast.jpg',
    ),
    Song(
      title: 'God’s Plan',
      artist: 'Drake',
      description: 'God’s Plan',
      url: 'assets/music/god.mp3',
      coverUrl: 'assets/images/god.jpg',
    ),

  ];
}
