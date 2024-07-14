import 'dart:convert';
import 'package:http/http.dart' as http;

class GeniusService {
  static const String _baseUrl = 'https://api.genius.com/';
  static const String _accessToken = 'SAp3Q1c6spGDSg0Hi3Cb4XjF6PkSuHQFwbsqqkQGn9xclgc7Yws2mrlPX4wM4xHy'; // api key

  static Future<String?> fetchLyrics(String songTitle, String artist) async {
    final searchUrl = '$_baseUrl/search?q=${Uri.encodeQueryComponent(songTitle + ' ' + artist)}';
    final response = await http.get(Uri.parse(searchUrl), headers: {
      'Authorization': 'Bearer $_accessToken',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final songData = data['response']['hits'][0]['result'];
      final songUrl = songData['url'];

      return _scrapeLyrics(songUrl);
    } else {
      throw Exception('Failed to load lyrics: ${response.statusCode} ${response.body}');
    }
  }

  static Future<String?> _scrapeLyrics(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final lyricsPage = response.body;
      return _extractLyricsFromHtml(lyricsPage);
    } else {
      throw Exception('Failed to load lyrics from the song page: ${response.statusCode}');
    }
  }

  static String? _extractLyricsFromHtml(String html) {
    final RegExp regex = RegExp(r'<div class="lyrics">.*?<p>(.*?)</p>', dotAll: true);
    final match = regex.firstMatch(html);
    return match != null ? match.group(1) : 'Paroles non trouvées';
  }
}
