import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

class GeniusService {
  static const String _baseUrl = 'api.genius.com';
  static const String _accessToken =
      'SAp3Q1c6spGDSg0Hi3Cb4XjF6PkSuHQFwbsqqkQGn9xclgc7Yws2mrlPX4wM4xHy'; // API key

  static Future<String?> fetchLyrics(String songTitle, String artist) async {
    final queryParameters = {'q': '$songTitle $artist'};
    final url = Uri.https(_baseUrl, '/search', queryParameters);

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_accessToken',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['response']['hits'].isNotEmpty) {
        final songData = data['response']['hits'][0]['result'];
        final songUrl = songData['url'];

        return await _scrapeLyrics(songUrl);
      } else {
        return 'Paroles non trouvées';
      }
    } else {
      throw Exception(
          'Échec du chargement des paroles: ${response.statusCode} ${response.body}');
    }
  }

  static Future<String?> _scrapeLyrics(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final lyricsPage = response.body;
      return _extractLyricsFromHtml(lyricsPage);
    } else {
      throw Exception(
          'Échec du chargement des paroles depuis la page de la chanson: ${response.statusCode}');
    }
  }

  static String? _extractLyricsFromHtml(String html) {
    final document = parse(html);
    final lyricsDiv = document.querySelector('div.lyrics') ??
        document.querySelector('div[class*="Lyrics__Root"]');

    if (lyricsDiv != null) {
      // Extract the text content and clean up any unwanted sections
      final lyrics = lyricsDiv.text.trim();
      return _cleanLyrics(lyrics);
    } else {
      return 'Paroles non trouvées';
    }
  }

  static String _cleanLyrics(String lyrics) {
    final unwantedPatterns = [
      RegExp(r'^\d+\s*Contributors', multiLine: true),
      RegExp(r'\[.*?\]', multiLine: true),
      RegExp(r'\d+\s*Translations', multiLine: true),
    ];

    // Supprimer les motifs non désirés
    for (var pattern in unwantedPatterns) {
      lyrics = lyrics.replaceAll(pattern, '');
    }

    // Supprimer les lignes restantes avec des caractères spéciaux au début
    lyrics =
        lyrics.split('\n').where((line) => !line.startsWith('[')).join('\n');

    // Ajouter un retour à la ligne avant les lettres majuscules qui ne sont pas en début de ligne
    lyrics = lyrics.replaceAllMapped(
        RegExp(r'(?<=[a-z])(?=[A-Z])'), (Match m) => '\n\n');

    // Ajouter un retour à la ligne après chaque parenthèse fermante
    lyrics = lyrics.replaceAllMapped(
        RegExp(r'(\))'), (Match m) => '${m.group(1)}\n\n');

    // Ajouter un espace entre chaque phrase
    lyrics = lyrics.replaceAllMapped(
        RegExp(r'(?<=[.?!])\s*(?=[A-Z])'), (Match m) => '${m.group(0)}\n\n');

    // Supprimer les retours à la ligne supplémentaires et couper les espaces en trop
    return lyrics.trim();
  }
}

void main() async {
  String? lyrics = await GeniusService.fetchLyrics('Polaroide', 'Youssoupha');
  print(lyrics);
}
