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
      title: 'Risky',
      description: 'Risky',
      artist: 'Davido',
      url: 'assets/music/risky.mp3',
      coverUrl: 'assets/images/risky.jpg',
    ),
    Song(
      title: 'Aye',
      artist: 'Davido',
      description: 'Aye',
      url: 'assets/music/aye.mp3',
      coverUrl: 'assets/images/aye.jpg',
    ),
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
      title: 'l’eau',
      artist: 'Lefa',
      description: 'vas prendre',
      url: 'assets/music/eau.mp3',
      coverUrl: 'assets/images/lefa1.jpg',
    ),
    Song(
      title: 'Penalty',
      artist: 'Lefa',
      description: 'Penalty',
      url: 'assets/music/penalty.mp3',
      coverUrl: 'assets/images/penalty.jpg',
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
    Song(
      title: 'l’argent',
      artist: 'Youssoupha',
      description: 'Money',
      url: 'assets/music/vacation.mp3',
      coverUrl: 'assets/images/youss.jpg',
    ),
  ];
}
