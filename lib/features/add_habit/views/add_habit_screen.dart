import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/theme/app_colors.dart';
import 'package:habit_tracker/core/widgets/common_app_bar.dart';

class AddHabitLightScreen extends StatefulWidget {
  const AddHabitLightScreen({super.key});

  @override
  State<AddHabitLightScreen> createState() => _AddHabitLightScreenState();
}

class _AddHabitLightScreenState extends State<AddHabitLightScreen> {
  int selectedCategory = 0;
  int selectedFrequency = 0;
  bool reminder = true;

  final List<String> categories = ["Health", "Mind", "Productivity", "Other"];

  final List<String> frequencyTabs = ["Daily", "Weekly", "Specific"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: CommonAppBar(title: "Add New Habit"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ////////////////////////////////////////////////////////////
              /// HABIT NAME
              ////////////////////////////////////////////////////////////
              sectionTitle("Habit Name"),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 55,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.border),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "e.g. Morning Meditation",
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              ////////////////////////////////////////////////////////////
              /// CATEGORY
              ////////////////////////////////////////////////////////////
              sectionTitle("Category"),
              const SizedBox(height: 12),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  categories.length,
                  (index) => categoryChip(index),
                ),
              ),

              const SizedBox(height: 30),

              ////////////////////////////////////////////////////////////
              /// CHOOSE ICON
              ////////////////////////////////////////////////////////////
              sectionTitle("Choose Icon"),
              const SizedBox(height: 15),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: List.generate(
                  8,
                  (index) => iconCircle(selected: index == 0),
                ),
              ),

              const SizedBox(height: 30),

              ////////////////////////////////////////////////////////////
              /// FREQUENCY
              ////////////////////////////////////////////////////////////
              sectionTitle("Frequency"),
              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: List.generate(
                    frequencyTabs.length,
                    (index) => frequencyTab(index),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ////////////////////////////////////////////////////////////
              /// DAYS
              ////////////////////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "M",
                  "T",
                  "W",
                  "T",
                  "F",
                  "S",
                  "S",
                ].map((day) => dayCircle(day)).toList(),
              ),

              const SizedBox(height: 30),

              ////////////////////////////////////////////////////////////
              /// GOAL VALUE & TARGET
              ////////////////////////////////////////////////////////////
              Row(
                children: [
                  Expanded(child: inputBox("Goal Value", "10", "min")),
                  const SizedBox(width: 15),
                  Expanded(child: inputBox("Target", "1", "times")),
                ],
              ),

              const SizedBox(height: 30),

              ////////////////////////////////////////////////////////////
              /// REMINDER
              ////////////////////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  sectionTitle("Reminder"),
                  Switch(
                    value: reminder,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      setState(() {
                        reminder = val;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.notifications, color: AppColors.primary),
                        SizedBox(width: 10),
                        Text("Morning notification"),
                      ],
                    ),
                    const Text(
                      "08:30 AM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              ////////////////////////////////////////////////////////////
              /// CREATE BUTTON
              ////////////////////////////////////////////////////////////
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x335B5FEF),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Create Habit 🚀",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  /// WIDGETS
  ////////////////////////////////////////////////////////////

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget categoryChip(int index) {
    bool selected = selectedCategory == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          categories[index],
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget iconCircle({bool selected = false}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.card,
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.border,
          width: 2,
        ),
      ),
      child: const Center(child: Icon(Icons.fitness_center)),
    );
  }

  Widget frequencyTab(int index) {
    bool selected = selectedFrequency == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFrequency = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              frequencyTabs[index],
              style: TextStyle(
                color: selected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dayCircle(String day) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(day, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget inputBox(String title, String value, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(title),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 55,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value),
              Text(
                unit,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
