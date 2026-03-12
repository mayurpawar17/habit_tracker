import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/theme/app_colors.dart';
import 'package:habit_tracker/features/add_habit/views/add_habit_screen.dart';
import 'package:habit_tracker/features/add_habit/views/habit_details_screen.dart';
import 'package:habit_tracker/features/habit/bloc/habit_bloc.dart';
import 'package:habit_tracker/features/habit/bloc/habit_event.dart';
import 'package:habit_tracker/features/habit/data/repo/habit_repo.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../habit/bloc/habit_state.dart';
import '../widgets/habit_tile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<HabitBloc>().add(LoadHabits(date: selectedDate));
  }

  final habitrepo = HabitService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: BlocBuilder<HabitBloc, HabitState>(
          builder: (context, state) {
            // if (state is HabitLoading) {
            //   return const Center(child: CircularProgressIndicator());
            // }

            final habits = state.habits;

            // if (habits.isEmpty) {
            //   return const Center(child: Text("No Habits"));
            // }

            return Column(
              children: [
                _buildCalendarTimeline(),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      final habit = habits[index];

                      print(habit);
                      // final habit = Habit.fromMap(
                      //   data.id,
                      //   data.data() as Map<String, dynamic>,
                      // );

                      return HabitTile(
                        title: habit.title,
                        icon: Icons.task,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HabitDetailScreen(habit: habit),
                            ),
                          );
                        },
                        isDone: habit.isDone,
                        onChanged: (bool? value) {
                          print("Habit ID: ${habit.id}");
                          context.read<HabitBloc>().add(
                            ToggleHabit(
                              habitId: habit.id,
                              isDone: value ?? false,
                            ),
                          );
                        },
                      );

                      // return ListTile(
                      //   title: Text(habit.title),
                      //   trailing: IconButton(
                      //     icon: Icon(Icons.delete),
                      //     onPressed: () {
                      //       habitService.deleteHabit(habit.id);
                      //     },
                      //   ),
                      // );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: AppColors.primary,

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddHabitScreen()),
          );
        },
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedAdd01,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCalendarTimeline() {
    return EasyDateTimeLine(
      initialDate: selectedDate,
      onDateChange: (date) {
        habitrepo.getHabitsForDate(date);
        print("asdfaf");
        setState(() {
          selectedDate = date;
        });
        context.read<HabitBloc>().add(LoadHabits(date: date));
      },
      headerProps: const EasyHeaderProps(
        showMonthPicker: false,
        selectedDateStyle: TextStyle(color: Colors.transparent),
      ),
      dayProps: const EasyDayProps(
        height: 80,
        width: 60,
        dayStructure: DayStructure.dayStrDayNum,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Color(0xFF1D2235), // Dark background for active day
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          dayNumStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          dayStrStyle: TextStyle(color: Colors.white, fontSize: 12),
        ),
        inactiveDayStyle: DayStyle(
          dayNumStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          dayStrStyle: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }
}
