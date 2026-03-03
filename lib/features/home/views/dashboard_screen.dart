import 'package:flutter/material.dart';
import 'package:habit_tracker/core/theme/app_colors.dart';
import 'package:habit_tracker/features/add_habit/views/add_habit_screen.dart';
import 'package:habit_tracker/features/add_habit/views/habit_details_screen.dart';
import 'package:habit_tracker/features/habit/data/model/habit_model.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../habit/data/repo/habit_repo.dart';
import '../widgets/habit_tile.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final habitService = HabitService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: StreamBuilder(
          stream: habitService.getHabits(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final docs = snapshot.data!.docs;

            return docs.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index];
                      final habit = Habit.fromMap(
                        data.id,
                        data.data() as Map<String, dynamic>,
                      );

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
                        onChanged: (bool? value) {},
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
                  )
                : Center(child: Text("No Habits"));
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
}
