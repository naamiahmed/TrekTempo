import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/Models/weatherModel.dart';
import 'package:travel_app/Pages/Destinations/place/weather/const.dart';

class WeatherApi {
  final String baseURl = "https://api.weatherapi.com/v1/current.json";

  Future<ApiResponse> getCurrentWeather(String district) async {
    String apiUrl = "$baseURl?key=$apiKey&q=$district";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        throw Exception("Invalid request. Please check the city name.");
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized. Please check your API key.");
      } else {
        throw Exception("Failed to load weather data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Network error: ${e.toString()}");
    }
  }
}