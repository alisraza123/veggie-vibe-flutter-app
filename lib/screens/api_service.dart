import 'dart:convert';
import 'package:http/http.dart' as http;

class NutritionService {
  static const String _apiKey = 'rOnLuUgQq7aonpIHn5vcg2ViLmsQ8OoTiOQSZUGF';
  static const String _baseUrl = 'https://api.api-ninjas.com/v1/nutrition';

  static Future<Map<String, dynamic>?> getNutrition(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?query=$query'),
        headers: {'X-Api-Key': _apiKey},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return data[0]; // Pehla match return kar rahe hain
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}