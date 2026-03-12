import 'package:equatable/equatable.dart';

import '../data/model/habit_model.dart';

abstract class HabitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHabits extends HabitEvent {
  final DateTime date;

  LoadHabits({required this.date});
}

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

/// Create new habit
class CreateHabit extends HabitEvent {
  final Habit habit;

  CreateHabit({required this.habit});
}
