import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_playground/application/weather_state.dart';

import 'package:flutter_riverpod_playground/domain/weather.dart';
import 'package:flutter_riverpod_playground/presentation/pages/weather_search_page.dart';

class WeatherDetailPage  extends StatefulWidget {
  final Weather masterWeather;
  const WeatherDetailPage ({Key? key, required this.masterWeather,}) : super(key: key);

  @override
  _WeatherDetailPage createState() => _WeatherDetailPage();
}

class _WeatherDetailPage extends State<WeatherDetailPage> {

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
        () => context
            .read(weatherStateNotifierProvider.notifier)
            .getDetailedWeather(widget.masterWeather.cityName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Detail"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Consumer(
          builder: (_, watch, child) {
            final state = watch(weatherStateNotifierProvider);

            if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(context, state.weather);
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the Celsius temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} ??C",
          style: TextStyle(fontSize: 80),
        ),
        Text(
          // Display the Fahrenheit temperature with 1 decimal place
          "${weather.temperatureFahrenheit?.toStringAsFixed(1)} ??F",
          style: TextStyle(fontSize: 80),
        ),
      ],
    );
  }
}
