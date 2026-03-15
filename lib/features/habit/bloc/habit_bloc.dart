import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/habit_repo.dart';
import 'habit_event.dart';
import 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitService habitService;

  HabitBloc(this.habitService) : super(HabitState()) {
    on<LoadHabits>(_onLoadHabits);
    on<AddHabit>(_addHabit);
    on<CreateHabit>(_onCreateHabit);
    on<ToggleHabit>(_toggleHabit);
  }

  Future<void> _toggleHabit(ToggleHabit event, Emitter<HabitState> emit) async {
    await habitService.toggleHabit(
      habitId: event.habitId,
      isDone: event.isDone,
    );

    final habits = await habitService.getHabits();

    emit(state.copyWith(habits: habits));
  }

  Future<void> _onLoadHabits(LoadHabits event, Emitter<HabitState> emit) async {
    try {
      // emit(HabitLoading());
      emit(state.copyWith(selectedDate: event.date));

      final habits = await habitService.getHabitsForDate(
        event.date,
      ); // fetch once
      // print("HabitBloc : ${habits.toString()}");
      emit(state.copyWith(habits: habits));
    } catch (e) {
      // emit(HabitError("Failed to load habits"));
    }
  }

  Future<void> _addHabit(AddHabit event, Emitter<HabitState> emit) async {
    // await habitService.addHabit(event.title);
    //
    // final habits = await habitService.getHabits();
    // emit(state.copyWith(habits: habits));
  }

  Future<void> _onCreateHabit(
    CreateHabit event,
    Emitter<HabitState> emit,
  ) async {
    try {
      // 1. Use the data from the event.habit object
      await habitService.createHabit(
        title: event.habit.title,
        goal: event.habit.goal,
        frequency: event.habit.frequency,
        // Pass other fields if your service supports them
      );

      // 2. Refresh the list so the UI updates
      final habits = await habitService.getHabits();
      print("All Habits :  $habits");
      emit(state.copyWith(habits: habits));
    } catch (e) {
      // Optional: emit an error state here
      print("Error creating habit: $e");
    }
  }
}
