part of 'farm_select_bloc.dart';

abstract class FarmSelectEvent extends Equatable {
  const FarmSelectEvent();

  @override
  List<Object> get props => [];
}

class FarmSelectChangeEvent extends FarmSelectEvent {
  final String name;

  const FarmSelectChangeEvent({required this.name});

  @override
  List<Object> get props => [name];
}
