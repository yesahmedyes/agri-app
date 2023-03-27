import 'package:agriapp/data/repositories/farm_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'get_farm_event.dart';
part 'get_farm_state.dart';

class GetFarmBloc extends Bloc<GetFarmEvent, GetFarmState> {
  final FarmRepository farmRepository;

  GetFarmBloc({required this.farmRepository}) : super(GetFarmInitialState()) {
    on<GetFarmSaveEvent>((event, emit) async {
      emit(GetFarmSavingState());

      await farmRepository.saveFarm(event.coordinates, event.name);

      emit(GetFarmSavedState());
    });
  }
}
