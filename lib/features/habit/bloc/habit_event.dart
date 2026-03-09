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

class ToggleHabit extends HabitEvent {
  final String habitId;
  final bool isDone;

  ToggleHabit({required this.habitId, required this.isDone});
}
