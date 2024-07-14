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
      title: 'Posty',
      description: 'Patience',
      artist: 'post malone',
      url: 'assets/music/amapiano.mp3',
      coverUrl: 'assets/images/patient.jpg',
    ),
    Song(
      title: 'LilTjay',
      artist: 'lil tjay',
      description: 'First love',
      url: 'assets/music/ambition.mp3',
      coverUrl: 'assets/images/tjay.jpg',
    ),
    Song(
      title: 'Gospel',
      artist: 'abrite',
      description: 'abrite moi',
      url: 'assets/music/competition.mp3',
      coverUrl: 'assets/images/abrite.jpg',
    ),
    Song(
      title: 'Avoir de l’argent',
      artist: 'Youssoupha',
      description: 'Avoir de l\'argent',
      url: 'assets/music/vacation.mp3',
      coverUrl: 'assets/images/youss.jpg', 
    ),
  ];
}
