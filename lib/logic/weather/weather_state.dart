part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherFetchedState extends WeatherState {
  final Map<DateTime, Weather> weather;

  const WeatherFetchedState({required this.weather});

  @override
  List<Object> get props => [weather];
}
