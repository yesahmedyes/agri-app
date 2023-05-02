import 'package:agriapp/data/models/weather.dart';
import 'package:agriapp/data/repositories/weather_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  final Map<LatLng, Map<DateTime, Weather>> cachedWeather = {};

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitialState()) {
    on<WeatherFetchEvent>((event, emit) async {
      emit(WeatherInitialState());

      if (!cachedWeather.containsKey(event.latLng)) {
        final Map<DateTime, Weather> weather = await weatherRepository.getWeather(event.latLng);

        cachedWeather[event.latLng] = weather;
      }

      emit(WeatherFetchedState(weather: cachedWeather[event.latLng]!));
    });
  }
}
