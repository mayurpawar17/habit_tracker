import 'package:equatable/equatable.dart';

import '../data/model/habit_model.dart';

class HabitState extends Equatable {
  final List<Habit> habits;
  final String? error;

  const HabitState({this.habits = const [], this.error});

  HabitState copyWith({List<Habit>? habits, String? error}) {
    return HabitState(
      habits: habits ?? this.habits,

      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [habits, error];
}
