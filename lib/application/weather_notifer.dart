import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod_playground/application/weather_state.dart';
import 'package:flutter_riverpod_playground/infrastructure/weather_repository.dart';

class WeatherStateNotifier extends StateNotifier<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherStateNotifier(ProviderReference ref) : weatherRepository = ref.read(fakeWeatherRepositoryProvider), super(WeatherInitial());

  void getWeather(String cityName) async {
    state = WeatherLoading();
    
    try {
      final weather = await weatherRepository.fetchWeather(cityName);
      state = WeatherLoaded(weather);
    } on NetworkException {
      state = WeatherError("Couldn't fetch weather. Is the device online?");
    }
  }

  void getDetailedWeather(String cityName) async {
    state = WeatherLoading();
    
    try {
      final weather = await weatherRepository.fetchDetailedWeather(cityName);
      state = WeatherLoaded(weather);
    } on NetworkException {
      state = WeatherError("Couldn't fetch weather. Is the device online?");
    }
  }
}