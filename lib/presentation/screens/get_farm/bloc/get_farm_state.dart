part of 'get_farm_bloc.dart';

abstract class GetFarmState extends Equatable {
  const GetFarmState();

  @override
  List<Object> get props => [];
}

class GetFarmInitialState extends GetFarmState {}

class GetFarmSavingState extends GetFarmState {}

class GetFarmSavedState extends GetFarmState {}
