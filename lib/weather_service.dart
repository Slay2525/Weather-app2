import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to load weather');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fethch the curent location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    //convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // extract the city name from the first placemark
    String? city = placemarks[0].locality;
    return city ?? "Unknown City";
  }
}
