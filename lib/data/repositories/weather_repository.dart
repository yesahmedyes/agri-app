import 'dart:convert';

import 'package:agriapp/data/models/weather.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  final Map<LatLng, Map<DateTime, Weather>> weatherData = {};

  Future<Map<DateTime, Weather>> getWeather(LatLng latLng) async {
    final response = await http.get(
      Uri.https(
        'weatherbit-v1-mashape.p.rapidapi.com',
        "/forecast/3hourly",
        {'lat': latLng.latitude.toString(), 'lon': latLng.longitude.toString()},
      ),
      headers: {
        'X-RapidAPI-Key': 'ece0c0717emsh38762180b3ce17cp1ec186jsn5174ed7d45f3',
        'X-RapidAPI-Host': 'weatherbit-v1-mashape.p.rapidapi.com',
      },
    );

    final Map<DateTime, Weather> currentWeatherData = {};

    if (response.statusCode != 200) {
      return {};
    }

    final data = jsonDecode(response.body);

    data['data'].forEach((each) {
      final weather = Weather(
        cityName: data['city_name'],
        windSpeed: double.parse(each['wind_spd'].toString()),
        windDirection: each['wind_cdir_full'],
        humidity: each['rh'],
        precipitation: double.parse(each['precip'].toString()),
        solarRadiation: double.parse(each['solar_rad'].toString()),
        temperature: double.parse(each['temp'].toString()),
        description: each['weather']['description'],
      );

      final tempDate = DateTime.parse(each['timestamp_utc']);

      final date = DateTime(tempDate.year, tempDate.month, tempDate.day);

      currentWeatherData[date] = weather;
    });

    return currentWeatherData;
  }
}
