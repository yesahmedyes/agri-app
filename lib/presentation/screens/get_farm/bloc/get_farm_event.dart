part of 'get_farm_bloc.dart';

abstract class GetFarmEvent extends Equatable {
  const GetFarmEvent();

  @override
  List<Object> get props => [];
}

class GetFarmSaveEvent extends GetFarmEvent {
  final List<LatLng> coordinates;
  final String name;

  const GetFarmSaveEvent({required this.coordinates, required this.name});

  @override
  List<Object> get props => [coordinates, name];
}
