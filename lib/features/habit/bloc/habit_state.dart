import 'package:equatable/equatable.dart';

import '../data/model/habit_model.dart';

class HabitState extends Equatable {
  final List<Habit> habits;
  final String? error;
  final DateTime? selectedDate; // Add this

  const HabitState({this.habits = const [], this.error, this.selectedDate});

  HabitState copyWith({
    List<Habit>? habits,
    String? error,
    DateTime? selectedDate,
  }) {
    return HabitState(
      habits: habits ?? this.habits,

      error: error ?? this.error,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [habits, error];
}
