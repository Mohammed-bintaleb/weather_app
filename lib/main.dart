import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/view_models/weather_cubit_cubit.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/views/home_page.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherCubit(WeatherService()),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          final weatherModel = context.read<WeatherCubit>().weatherModel;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: weatherModel?.getThemeColor() ?? Colors.blue,
            ),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
