import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> {
  SoundBloc() : super(SoundOnState()) {
    on<SoundTurnOnEvent>((event, emit) {
      emit(SoundOnState());
    });
    on<SoundTurnOffEvent>((event, emit) {
      emit(SoundOffState());
    });
  }
}
