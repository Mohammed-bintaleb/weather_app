import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/view_models/weather_cubit_cubit.dart';
import 'package:weather_app/views/search_page.dart';
import 'package:weather_app/widgets/custom_text.dart';
import '../widgets/no_weather_body.dart';
import '../widgets/weather_info_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => const SearchPage()),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const CustomText(text: "Weather App"),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          if (state is WeatherInitial) {
            return const NoWeatherBody();
          } else if (state is WeatherLoadedState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherSuccessState) {
            return const WeatherInfoBody();
          } else if (state is WeatherFailureState) {
            return const Center(
              child: Text("An error occurred while loading data."),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
