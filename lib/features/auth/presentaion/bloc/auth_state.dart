import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_tracker/features/profile/data/models/user_response.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final User? user;
  final UserResponse? userResponse;
  final String? name;

  Authenticated({this.userResponse, this.name, this.user});

  @override
  List<Object?> get props => [userResponse, user];
}

class Unauthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
