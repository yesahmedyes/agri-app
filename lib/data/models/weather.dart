import 'dart:convert';

class Weather {
  final String cityName;
  final double windSpeed;
  final String windDirection;
  final int humidity;
  final double precipitation;
  final double solarRadiation;
  final double temperature;
  final String description;

  Weather({required this.cityName, required this.windSpeed, required this.windDirection, required this.humidity, required this.precipitation, required this.solarRadiation, required this.temperature, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'windSpeed': windSpeed,
      'windDirection': windDirection,
      'humidity': humidity,
      'precipitation': precipitation,
      'solarRadiation': solarRadiation,
      'temperature': temperature,
      'description': description,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      cityName: map['cityName'] ?? '',
      windSpeed: map['windSpeed']?.toDouble() ?? 0.0,
      windDirection: map['windDirection'] ?? '',
      humidity: map['humidity']?.toInt() ?? 0,
      precipitation: map['precipitation']?.toDouble() ?? 0.0,
      solarRadiation: map['solarRadiation']?.toDouble() ?? 0.0,
      temperature: map['temperature']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) => Weather.fromMap(json.decode(source));
}
