part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileSubmitEvent extends ProfileEvent {
  final String fullName;
  final String email;

  const ProfileSubmitEvent({required this.fullName, required this.email});

  @override
  List<Object> get props => [fullName, email];
}
