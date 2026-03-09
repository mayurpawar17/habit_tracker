import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/habit_repo.dart';
import 'habit_event.dart';
import 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitService habitService;

  HabitBloc(this.habitService) : super(HabitState()) {
    on<LoadHabits>(_onLoadHabits);
    on<AddHabit>(_addHabit);
    on<ToggleHabit>(_toggleHabit);
  }
  Future<void> _toggleHabit(ToggleHabit event, Emitter<HabitState> emit) async {
    await habitService.updateHabitStatus(event.habitId, event.isDone);

    final habits = await habitService.getHabits();

    emit(state.copyWith(habits: habits));
  }

  Future<void> _onLoadHabits(LoadHabits event, Emitter<HabitState> emit) async {
    try {
      // emit(HabitLoading());

      final habits = await habitService.getHabits(); // fetch once

      emit(state.copyWith(habits: habits));
    } catch (e) {
      // emit(HabitError("Failed to load habits"));
    }
  }

  Future<void> _addHabit(AddHabit event, Emitter<HabitState> emit) async {
    await habitService.addHabit(event.title);

    final habits = await habitService.getHabits();
    emit(state.copyWith(habits: habits));
  }
}
