import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_weather/constants/constants.dart';

class WeatherService {
  final String apiKey = Constants.apiKey; // Replace with your API key

  Future<Map<String, dynamic>?> fetchWeather(String cityName) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error fetching weather data: ${response.statusCode}');
      return null;
    }
  }
}
