part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeChangeToHomeEvent extends HomeEvent {}

class HomeChangeToReportsEvent extends HomeEvent {}

class HomeChangeToChatEvent extends HomeEvent {}

class HomeChangeToProfileEvent extends HomeEvent {}
