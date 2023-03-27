import 'package:agriapp/data/models/weather.dart';
import 'package:agriapp/data/repositories/weather_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitialState()) {
    on<WeatherFetchEvent>((event, emit) async {
      emit(WeatherInitialState());

      final Map<DateTime, Weather> weather = await weatherRepository.getWeather(const LatLng(35.5, -70));

      emit(WeatherFetchedState(weather: weather));
    });
  }
}
