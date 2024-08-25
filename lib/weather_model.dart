class Weather {
  final String cityName;
  final double temperature;
  Weather({required this.cityName, required this.temperature});
  factory Weather.fromJson(dynamic json) {
    return Weather(
        cityName: json['name'], temperature: json['main']['temp'].toDouble());
  }
}
