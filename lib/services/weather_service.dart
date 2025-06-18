import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  WeatherService();

  final String baseUrl = "http://api.weatherapi.com/v1";
  final String apiKey = "3677bed892474b30b7a122242220806";
  final Dio dio = Dio();

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      final response = await dio.get(
        '$baseUrl/forecast.json',
        queryParameters: {'key': apiKey, 'q': cityName, 'days': 7},
      );

      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      String errorMessage = "An unexpected error occurred. Please try again.";

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorMessage = "Connection timed out. Please check your internet.";
      } else if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        final serverMessage = e.response?.data['error']?['message'];

        if (statusCode == 400 || statusCode == 404) {
          errorMessage = serverMessage ?? "City not found.";
        } else {
          errorMessage = serverMessage ?? "Server error. Please try again.";
        }
      } else if (e.type == DioExceptionType.unknown) {
        errorMessage = "No internet connection or unexpected error occurred.";
      }

      log("Dio error: ${e.message}");
      throw Exception(errorMessage);
    } catch (e, stackTrace) {
      log("Unexpected error: $e", stackTrace: stackTrace);
      throw Exception("Something went wrong. Please try again later.");
    }
  }
}
