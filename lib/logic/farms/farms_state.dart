part of 'farms_bloc.dart';

abstract class FarmsState extends Equatable {
  const FarmsState();

  @override
  List<Object> get props => [];
}

class FarmsInitialState extends FarmsState {}

class FarmsLoadedState extends FarmsState {
  final List<Farm> farms;

  const FarmsLoadedState({required this.farms});

  @override
  List<Object> get props => [farms];
}
