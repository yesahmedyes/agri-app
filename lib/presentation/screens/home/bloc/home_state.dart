part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeReportsState extends HomeState {}

class HomeChatState extends HomeState {}

class HomeProfileState extends HomeState {}
