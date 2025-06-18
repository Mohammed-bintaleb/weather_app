import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit_cubit.dart';
import 'custom_text.dart';

class WeatherInfoBody extends StatelessWidget {
  const WeatherInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherModel = BlocProvider.of<WeatherCubit>(context).weatherModel;

    if (weatherModel == null) {
      return const Center(child: Text("لا توجد بيانات طقس متاحة"));
    }

    final themeColor = weatherModel.getThemeColor();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeColor,
            themeColor[300] ?? themeColor,
            themeColor[100] ?? themeColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          Expanded(
            child: CustomText(
              text: weatherModel.cityName,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: CustomText(
              text:
                  'updated at : ${weatherModel.date.hour.toString().padLeft(2, '0')}:${weatherModel.date.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 22),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              weatherModel.image != null
                  ? Image.network("https:${weatherModel.image}")
                  : Image.asset(weatherModel.getImage()),
              CustomText(
                text: '${weatherModel.temp.toInt()}°',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              Column(
                children: [
                  CustomText(text: 'max: ${weatherModel.maxTemp.toInt()}°'),
                  CustomText(text: 'min: ${weatherModel.minTemp.toInt()}°'),
                ],
              ),
            ],
          ),
          const Spacer(),
          CustomText(
            text: weatherModel.weatherCondition,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
