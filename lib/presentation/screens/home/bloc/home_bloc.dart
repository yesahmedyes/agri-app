import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeChangeToHomeEvent>(_changeToHome);
    on<HomeChangeToReportsEvent>(_changeToReports);
    on<HomeChangeToProfileEvent>(_changeToProfile);
    on<HomeChangeToChatEvent>(_changeToChat);
  }

  void _changeToHome(HomeChangeToHomeEvent event, Emitter<HomeState> emit) {
    emit(HomeInitialState());
  }

  void _changeToReports(HomeChangeToReportsEvent event, Emitter<HomeState> emit) {
    emit(HomeReportsState());
  }

  void _changeToChat(HomeChangeToChatEvent event, Emitter<HomeState> emit) {
    emit(HomeChatState());
  }

  void _changeToProfile(HomeChangeToProfileEvent event, Emitter<HomeState> emit) {
    emit(HomeProfileState());
  }
}
