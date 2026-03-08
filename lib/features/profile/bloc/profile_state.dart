import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String? name;
  final String? email;
  final String? error;

  const ProfileState({this.name, this.email, this.error});

  ProfileState copyWith({
    bool? isLoading,
    String? name,
    String? email,
    String? error,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [name, email, error];
}
