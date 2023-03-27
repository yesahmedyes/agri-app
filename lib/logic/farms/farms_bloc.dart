import 'package:agriapp/data/models/farm.dart';
import 'package:agriapp/data/repositories/farm_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'farms_event.dart';
part 'farms_state.dart';

class FarmsBloc extends Bloc<FarmsEvent, FarmsState> {
  final FarmRepository farmRepository;

  FarmsBloc({required this.farmRepository}) : super(FarmsInitialState()) {
    on<FarmsLoadEvent>((event, emit) async {
      final farms = await farmRepository.getAllFarms();

      emit(FarmsLoadedState(farms: farms));
    });
  }
}
