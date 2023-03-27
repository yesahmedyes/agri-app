import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'farm_select_event.dart';
part 'farm_select_state.dart';

class FarmSelectBloc extends Bloc<FarmSelectEvent, FarmSelectState> {
  FarmSelectBloc() : super(FarmSelectInitialState()) {
    on<FarmSelectChangeEvent>((event, emit) {
      if (event.name.isNotEmpty) emit(FarmSelectedState(name: event.name));
    });
  }
}
