import 'dart:async';

import 'package:agriapp/data/models/farm.dart';
import 'package:agriapp/data/repositories/farm_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'farms_event.dart';
part 'farms_state.dart';

class FarmsBloc extends Bloc<FarmsEvent, FarmsState> {
  final FarmRepository farmRepository;
  StreamSubscription? subscription;

  FarmsBloc({required this.farmRepository}) : super(FarmsInitialState()) {
    on<FarmsLoadEvent>((event, emit) async {
      final farms = await farmRepository.getAllFarms();

      emit(FarmsLoadedState(farms: farms));

      subscription ??= farmRepository.stream.listen((List<Farm> farms) {
        add(FarmsLoadedEvent(farms: farms));
      });
    });
    on<FarmsLoadedEvent>((event, emit) {
      emit(FarmsInitialState());

      emit(FarmsLoadedState(farms: event.farms));
    });
  }
}
