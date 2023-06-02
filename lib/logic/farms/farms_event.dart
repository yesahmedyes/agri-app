part of 'farms_bloc.dart';

abstract class FarmsEvent extends Equatable {
  const FarmsEvent();

  @override
  List<Object> get props => [];
}

class FarmsLoadEvent extends FarmsEvent {}

class FarmsLoadedEvent extends FarmsEvent {
  final List<Farm> farms;

  const FarmsLoadedEvent({required this.farms});
}
