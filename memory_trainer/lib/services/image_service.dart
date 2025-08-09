import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageService {
  Future<List<String>> fetchRandomImageUrls(int count) async {
    final Uri url = Uri.parse('https://picsum.photos/v2/list?limit=$count');
    final http.Response response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to load images');
    }
    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data.map<String>((dynamic item) {
      final Map<String, dynamic> map = item as Map<String, dynamic>;
      return map['download_url'] as String;
    }).toList();
  }
}