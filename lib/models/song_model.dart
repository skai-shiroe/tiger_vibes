class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,
  });

  static List<Song> songs = [
    Song(
      title: 'Posty',
      description: 'Patience',
      url: 'assets/music/amapiano.mp3',
      coverUrl: 'assets/images/patient.jpg',
    ),
    Song(
      title: 'LilTjay',
      description: 'First love',
      url: 'assets/music/ambition.mp3',
      coverUrl: 'assets/images/tjay.jpg',
    ),
    Song(
      title: 'Gospel',
      description: 'abrite moi',
      url: 'assets/music/competition.mp3',
      coverUrl: 'assets/images/abrite.jpg',
    ),
    Song(
      title: 'Juice wrld',
      description: 'vacation',
      url: 'assets/music/vacation.mp3',
      coverUrl: 'assets/images/vacation.jpeg',
    ),
  ];
}
