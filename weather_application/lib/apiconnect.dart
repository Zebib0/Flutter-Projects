import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchWeather(String cityName) async {
  final apiKey = '6a6878e847538eec6785d8bc1dbc7bc8';
  final url = 'api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$apiKey&units=metric';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  } catch (e) {
    throw Exception('Failed to fetch weather data: $e');
  }
}
