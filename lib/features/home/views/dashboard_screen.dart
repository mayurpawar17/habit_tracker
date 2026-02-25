import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/theme/app_colors.dart';
import 'package:habit_tracker/features/add_habit/views/add_habit_screen.dart';
import 'package:habit_tracker/features/home/views/home_screen.dart';
import 'package:hugeicons/hugeicons.dart';

import 'habit_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good morning,", style: GoogleFonts.poppins(fontSize: 16)),
              Text(
                "Mayur",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    HabitCard(
                      color: AppColors.yellow,
                      title: "Reading",
                      subtitle: "Read 20 pages",
                    ),
                    HabitCard(
                      color: AppColors.pastelGreen,
                      title: "Workout",
                      subtitle: "30 min",
                    ),
                    HabitCard(
                      color: AppColors.blue,
                      title: "Programming",
                      subtitle: "Practice",
                    ),
                    HabitCard(
                      color: AppColors.pink,
                      title: "Finance",
                      subtitle: "Track expenses",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: AppColors.primary,

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddHabitLightScreen()),
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
