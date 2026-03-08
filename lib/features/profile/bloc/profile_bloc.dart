import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/profile_repo.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileState()) {
    on<LoadProfile>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final data = await repository.getUserProfile();

      emit(state.copyWith(name: data['name'], email: data['email']));
    } catch (e) {
      emit(state.copyWith(error: "Failed to load profile"));
    }
  }
}
