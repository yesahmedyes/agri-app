part of 'farm_select_bloc.dart';

abstract class FarmSelectState extends Equatable {
  const FarmSelectState();

  @override
  List<Object> get props => [];
}

class FarmSelectInitialState extends FarmSelectState {}

class FarmSelectedState extends FarmSelectState {
  final String name;

  const FarmSelectedState({required this.name});

  @override
  List<Object> get props => [name];
}
