import 'package:bloc/bloc.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

part 'weather_cubit_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherService) : super(WeatherInitial());
  WeatherModel? weatherModel;
  WeatherService weatherService;
  void getWeather({required String cityName}) async {
    emit(WeatherLoadedState());
    try {
      weatherModel = await weatherService.getCurrentWeather(cityName: cityName);
      emit(WeatherSuccessState());
    } on Exception {
      emit(WeatherFailureState());
    }
  }
}
