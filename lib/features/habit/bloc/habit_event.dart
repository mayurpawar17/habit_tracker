import 'package:equatable/equatable.dart';

abstract class HabitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHabits extends HabitEvent {}

class AddHabit extends HabitEvent {
  final String title;

  AddHabit({required this.title});

  @override
  List<Object?> get props => [title];
}
