import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class GeniusService {
  static const String _baseUrl = 'api.genius.com';
  static const String _accessToken = 'SAp3Q1c6spGDSg0Hi3Cb4XjF6PkSuHQFwbsqqkQGn9xclgc7Yws2mrlPX4wM4xHy'; // API key

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
      throw Exception('Échec du chargement des paroles: ${response.statusCode} ${response.body}');
    }
  }

  static Future<String?> _scrapeLyrics(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final lyricsPage = response.body;
      return _extractLyricsFromHtml(lyricsPage);
    } else {
      throw Exception('Échec du chargement des paroles depuis la page de la chanson: ${response.statusCode}');
    }
  }

  static String? _extractLyricsFromHtml(String html) {
    final document = parse(html);
    final lyricsDiv = document.querySelector('div.lyrics') ?? document.querySelector('div[class*="Lyrics__Root"]');

    if (lyricsDiv != null) {
      return lyricsDiv.text.trim();
    } else {
      return 'Paroles non trouvées';
    }
  }
}
