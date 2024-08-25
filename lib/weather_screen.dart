import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'weather_model.dart';
import 'dart:core';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService('c06ab1b596795f5e40480fdddf007dd1');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //catch  errors and display message
    catch (e) {
      print(e);
    }
  }

  @override
  initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_weather?.cityName ?? 'Loading...'),
              if (_weather != null)
                Text('${_weather?.temperature.round()}°C')
              else
                Text('Temperature not available'),
            ],
          ),
        ),
      ),
    );
  }
}
