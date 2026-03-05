import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/app_dialog.dart';
import 'package:habit_tracker/core/widgets/common_app_bar.dart';
import 'package:habit_tracker/features/habit/data/model/habit_model.dart';

import '../../../core/utils/app_snackbar.dart';
import '../../habit/data/repo/habit_repo.dart';
import '../../home/views/home_screen.dart';
import 'edit_habit_sheet.dart';

class HabitDetailScreen extends StatelessWidget {
  Habit? habit;

  HabitDetailScreen({super.key, this.habit});

  final habitService = HabitService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CommonAppBar(
        title: '',
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                // Allows sheet to expand with keyboard
                backgroundColor: Colors.transparent,
                builder: (context) => const EditHabitSheet(),
              );
            },
            icon: const Icon(Icons.edit, color: Colors.lightBlueAccent),
          ),
          IconButton(
            onPressed: () {
              AppDialog.showConfirmationDialog(
                context: context,
                title: 'Delete Habit',
                content:
                    'Start the day with 10 minutes of mindfulness to reduce stress and improve focus for the upcoming classes and work tasks. Use the Breath app or sit in silence.',
                onConfirm: () {
                  habitService.deleteHabit(habit!.id);
                  Navigator.pop(context);
                },
              );

              // showDeleteDialog(context, () {
              //   // Put your actual delete logic here
              //   // habitService.deleteHabit(habit!.id);
              //   AppSnackbar.success(context, "Habit deleted successfully");
              //   Navigator.pop(context);
              // });

              // habitService.deleteHabit(habit!.id);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (_) => HomeScreen()),
              // );
            },
            icon: const Icon(Icons.delete, color: Colors.redAccent),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeader(),
            const SizedBox(height: 32),

            // Streak Card
            _buildStreakCard(),
            const SizedBox(height: 20),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: _buildStatTile(
                    "TOTAL DONE",
                    "142 Times",
                    Icons.check_circle_outline,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatTile(
                    "COMP. RATE",
                    "92%",
                    Icons.bar_chart_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Calendar Section
            _buildCalendarSection(),
            const SizedBox(height: 32),

            // Description Section
            const Text(
              "Focus & Intent",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Start the day with 10 minutes of mindfulness to reduce stress and improve focus for the upcoming classes and work tasks. Use the Breath app or sit in silence.",
                style: TextStyle(
                  color: Colors.black54,
                  height: 1.6,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.cyan.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "DAILY • 7:00 AM",
            style: TextStyle(
              color: Colors.cyan,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          habit!.title,
          // "Morning\nMeditation",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CURRENT STREAK",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Text(
                    "15 ",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Days 👑",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "📈 BEST: 28 DAYS",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 75,
                height: 75,
                child: CircularProgressIndicator(
                  value: 0.75,
                  strokeWidth: 8,
                  backgroundColor: Colors.cyan.withOpacity(0.05),
                  color: Colors.cyan,
                ),
              ),
              const Text(
                "75%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatTile(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.indigoAccent.withOpacity(0.6), size: 28),
          const SizedBox(height: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "October 2023",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  _circleNav(Icons.chevron_left),
                  const SizedBox(width: 8),
                  _circleNav(Icons.chevron_right),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Simplified Calendar View
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 21,
            itemBuilder: (context, index) {
              bool isDone = [
                2,
                3,
                4,
                5,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
              ].contains(index + 1);
              return Container(
                decoration: BoxDecoration(
                  color: isDone ? Colors.cyan : Colors.cyan.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: isDone ? Colors.white : Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _circleNav(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: Colors.black54),
    );
  }

  void showDeleteDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Delete Habit",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Are you sure you want to delete this habit? This action cannot be undone.",
            style: TextStyle(color: Colors.black54),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: const Text(
                "Delete",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
