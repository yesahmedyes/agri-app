part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherFetchEvent extends WeatherEvent {
  final LatLng latLng;

  const WeatherFetchEvent({required this.latLng});

  @override
  List<Object> get props => [latLng];
}
