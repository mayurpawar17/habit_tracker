import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _repository = AuthService();

  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthStatus>((event, emit) {
      if (_repository.currentUser != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _repository.login(email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // on<SignupRequested>((event, emit) async {
    //   emit(AuthLoading());
    //   try {
    //     await _repository.signUp(
    //       email: event.email,
    //       password: event.password,
    //     );
    //     emit(Authenticated());
    //   } catch (e) {
    //     emit(AuthError(e.toString()));
    //   }
    // });

    on<LogoutRequested>((event, emit) async {
      await _repository.logout();
      emit(Unauthenticated());
    });
  }
}
