import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  GeminiService._private();
  static final GeminiService instance = GeminiService._private();

  static const _apiKey = 'YOUR_GEMINI_API_KEY'; // TODO: replace with actual key
  static const _endpoint = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  Future<String> translateText(String text, {String target = 'en'}) async {
    final response = await http.post(
      Uri.parse('$_endpoint?key=$_apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': 'Translate to $target: $text'}
            ]
          }
        ]
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'] as String;
    } else {
      throw Exception('Failed to translate: ${response.body}');
    }
  }
}
