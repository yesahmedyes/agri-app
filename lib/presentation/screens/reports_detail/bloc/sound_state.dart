part of 'sound_bloc.dart';

abstract class SoundState extends Equatable {
  const SoundState();

  @override
  List<Object> get props => [];
}

class SoundOnState extends SoundState {}

class SoundOffState extends SoundState {}
