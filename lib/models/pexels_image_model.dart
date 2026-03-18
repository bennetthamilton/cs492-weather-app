import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PexelsImage {
  Future<String?> getImage(String prompt) async {
    return getImageFromQueries([prompt]);
  }

  Future<String?> getImageFromQueries(List<String> queries) async {
    final apiKey = dotenv.env['PEXELS_API_KEY'];
    if (apiKey == null) return null;

    final random = Random();

    for (final query in queries) {
      final page = random.nextInt(10) + 1; // pages 1-10
      final uri = Uri.parse(
        'https://api.pexels.com/v1/search'
        '?query=${Uri.encodeComponent(query)}'
        '&per_page=1'
        '&page=$page',
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['photos'] != null && data['photos'].isNotEmpty) {
          return data['photos'][0]['src']['large'];
        }
      }
    }

    return null;
  }
}