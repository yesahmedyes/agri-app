import 'package:agriapp/data/repositories/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(ProfileInitialState()) {
    on<ProfileSubmitEvent>((event, emit) async {
      emit(ProfileSubmittingState());

      await _profileRepository.updateProfile(displayName: event.fullName, email: event.email);

      Fluttertoast.showToast(msg: 'Profile updated', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);

      emit(ProfileSubmitSuccessState());
    });
  }
}
