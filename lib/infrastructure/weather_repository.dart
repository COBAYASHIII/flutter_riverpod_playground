import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_playground/domain/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(
      String cityName); //←WeatherRepository has simple 1 Function fetchWeather
  Future<Weather> fetchDetailedWeather(String cityName);
}

final fakeWeatherRepositoryProvider =
    Provider<WeatherRepository>((ref) => FakeWeatherRepository());

class FakeWeatherRepository implements WeatherRepository {
  double? cachedTempCelsius;

  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        if (random.nextBool()) {
          throw NetworkException();
        }

        cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();

        return Weather(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius!,
        );
      },
    );
  }

  @override
  Future<Weather> fetchDetailedWeather(String cityName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return Weather(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius!,
          temperatureFahrenheit: cachedTempCelsius! * 1.8 + 32,
        );
      },
    );
  }
}

class NetworkException implements Exception {}
