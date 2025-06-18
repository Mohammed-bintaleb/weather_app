import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  WeatherService();

  String baseUrl = "http://api.weatherapi.com/v1";
  String apiKey = "3677bed892474b30b7a122242220806";

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      final url = Uri.parse(
        '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(data);
        return weatherModel;
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage =
            errorData['error']['message'] ??
            "An error occurred, try again later.";
        throw Exception(errorMessage);
      }
    } catch (e) {
      log(e.toString());
      throw Exception(
        "An error occurred while fetching data. Try again later.",
      );
    }
  }
}
