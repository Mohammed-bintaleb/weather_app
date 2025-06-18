part of 'weather_cubit_cubit.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoadedState extends WeatherState {}

class WeatherSuccessState extends WeatherState {}

class WeatherFailureState extends WeatherState {}
