import 'package:agriapp/data/models/farm.dart';
import 'package:agriapp/data/models/weather.dart';
import 'package:agriapp/logic/weather/weather_bloc.dart';
import 'package:agriapp/presentation/screens/reports/bloc/farm_select_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class FarmWeatherWidget extends StatelessWidget {
  final List<Farm> farms;

  const FarmWeatherWidget({super.key, required this.farms});

  _fetchWeather(BuildContext context, LatLng coords) {
    context.read<WeatherBloc>().add(WeatherFetchEvent(latLng: coords));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmSelectBloc, FarmSelectState>(
      builder: (context, state) {
        if (state is FarmSelectedState) {
          final Farm farm = farms.firstWhere((each) => (each.name == state.name));

          _fetchWeather(context, farm.coordinates.first);

          return BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, weatherState) {
              // return FarmWeatherRow(
              //   weather: {
              //     DateTime(2023, 3, 23): Weather(cityName: 'Lahore', windSpeed: 24, windDirection: 'North', humidity: 5, precipitation: 34.5, solarRadiation: 22.3, temperature: 23, description: 'Windy'),
              //     DateTime(2023, 3, 24): Weather(cityName: 'Lahore', windSpeed: 24, windDirection: 'North', humidity: 5, precipitation: 34.5, solarRadiation: 22.3, temperature: 23, description: 'Windy'),
              //     DateTime(2023, 3, 25): Weather(cityName: 'Lahore', windSpeed: 24, windDirection: 'North', humidity: 5, precipitation: 34.5, solarRadiation: 22.3, temperature: 23, description: 'Windy'),
              //     DateTime(2023, 3, 26): Weather(cityName: 'Lahore', windSpeed: 24, windDirection: 'North', humidity: 5, precipitation: 34.5, solarRadiation: 22.3, temperature: 23, description: 'Windy'),
              //     DateTime(2023, 3, 27): Weather(cityName: 'Lahore', windSpeed: 24, windDirection: 'North', humidity: 5, precipitation: 34.5, solarRadiation: 22.3, temperature: 23, description: 'Windy'),
              //   },
              // );

              if (weatherState is WeatherFetchedState && weatherState.weather.isNotEmpty) {
                return FarmWeatherRow(weather: weatherState.weather);
              }

              return const SizedBox.shrink();
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class FarmWeatherRow extends StatelessWidget {
  final Map<DateTime, Weather> weather;

  const FarmWeatherRow({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 17),
          ...weather.keys.map(
            (key) {
              return Container(
                width: screenWidth * 0.6,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      key.isBefore(DateTime.now()) ? 'Today' : DateFormat('EEEE').format(key),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${weather[key]!.temperature} °C',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Humidity', style: TextStyle(color: Colors.white)),
                            Text('${weather[key]!.humidity}%', style: const TextStyle(color: Colors.white)),
                            const SizedBox(height: 12),
                            const Text('Precipitation', style: TextStyle(color: Colors.white)),
                            Text('${weather[key]!.humidity} mm', style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Wind speed', style: TextStyle(color: Colors.white)),
                            Text('${weather[key]!.windSpeed} m/s', style: const TextStyle(color: Colors.white)),
                            const SizedBox(height: 12),
                            const Text('Solar radiation', style: TextStyle(color: Colors.white)),
                            Text('${weather[key]!.solarRadiation}', style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ).toList(),
          const SizedBox(width: 17),
        ],
      ),
    );
  }
}
