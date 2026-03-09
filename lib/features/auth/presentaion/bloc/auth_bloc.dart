import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _repository = AuthService();

  AuthBloc() : super(AuthInitial()) {
    // App start
    on<CheckAuthStatus>((event, emit) {
      final user = _repository.currentUser;
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _repository.login(
          email: event.email,
          password: event.password,
        );

        if (user != null) {
          final profile = await _repository.getUserProfile();

          final name = profile?['name'];
          final email = profile?['email'];
          emit(Authenticated(user: user, name: name));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(Unauthenticated());
      }
    });

    on<SignupRequested>((event, emit) async {
      try {
        emit(AuthLoading());

        final user = await _repository.register(
          email: event.email,
          password: event.password,
          name: event.name,
        );

        emit(Unauthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(Unauthenticated());
      }
    });

    on<LogoutRequested>((event, emit) async {
      await _repository.logout();
      emit(Unauthenticated());
    });
  }
}
