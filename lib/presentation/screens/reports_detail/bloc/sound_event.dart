part of 'sound_bloc.dart';

abstract class SoundEvent extends Equatable {
  const SoundEvent();

  @override
  List<Object> get props => [];
}

class SoundTurnOnEvent extends SoundEvent {}

class SoundTurnOffEvent extends SoundEvent {}
