import 'package:flutter/material.dart';
import 'package:flutter_riverpod_playground/presentation/pages/weather_search_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Riverpod Playground',
        home: WeatherSearchPage(),
      );
  }
}


