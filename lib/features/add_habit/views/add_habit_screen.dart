import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/theme/app_colors.dart';
import 'package:habit_tracker/core/widgets/app_button.dart';
import 'package:habit_tracker/core/widgets/common_app_bar.dart';

import '../../habit/bloc/habit_bloc.dart';
import '../../habit/bloc/habit_event.dart';
import '../../habit/data/repo/habit_repo.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _habitTitleController = TextEditingController();
  String selectedCategory = "Health";
  Color selectedColor = Colors.cyan;
  IconData selectedIcon = Icons.fitness_center;

  final List<String> categories = ["Health", "Work", "Personal", "Finance"];
  final List<Color> accentColors = [
    Colors.cyan,
    Colors.pinkAccent,
    Colors.orange,
    Colors.greenAccent,
    Colors.indigoAccent,
    Colors.purpleAccent,
    Colors.blueGrey,
  ];

  final habitService = HabitService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: 'Add New Habit'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Habit Name using your AppTextField
            const Text(
              "HABIT NAME",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _habitTitleController,
              decoration: InputDecoration(
                hintText: "e.g., Morning Meditation",
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            ),

            const SizedBox(height: 25),
            _sectionTitle("CATEGORY"),
            Wrap(
              spacing: 10,
              children: categories
                  .map(
                    (cat) => ChoiceChip(
                      label: Text(cat),
                      selected: selectedCategory == cat,
                      onSelected: (val) =>
                          setState(() => selectedCategory = cat),
                      selectedColor: Colors.cyan,
                      labelStyle: TextStyle(
                        color: selectedCategory == cat
                            ? Colors.white
                            : Colors.black54,
                      ),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("FREQUENCY"),
                      DropdownButtonFormField(
                        decoration: _inputStyle(),
                        value: "Daily",
                        items: ["Daily", "Weekly"]
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (v) {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("REMINDER"),
                      TextField(
                        readOnly: true,
                        decoration: _inputStyle().copyWith(
                          hintText: "08:00 AM",
                          prefixIcon: const Icon(Icons.access_time),
                          suffixIcon: const Icon(Icons.history_toggle_off),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
            _sectionTitle("CHOOSE ICON"),

            // Grid of icons would go here... (Simplified for brevity)
            const SizedBox(height: 25),
            _sectionTitle("ACCENT COLOR"),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: accentColors.length,
                separatorBuilder: (context, index) => const SizedBox(width: 15),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () =>
                      setState(() => selectedColor = accentColors[index]),
                  child: CircleAvatar(
                    backgroundColor: accentColors[index],
                    child: selectedColor == accentColors[index]
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Your Custom AppButton
            AppButton(
              // onPressed: () {
              //   final habitTitle = _habitTitleController.text.trim();
              //   // print('Habit : $habitTitle');
              //   habitService.addHabit(habitTitle);
              //   if (context.mounted) {
              //     context.read<HabitBloc>().add(LoadHabits());
              //     Navigator.pop(context);
              //   }
              // },
              onPressed: () {
                final habitTitle = _habitTitleController.text.trim();

                context.read<HabitBloc>().add(AddHabit(title: habitTitle));

                Navigator.pop(context);
              },
              label: 'Create Habit',
              backgroundColor: AppColors.primary,
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 55,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.cyan,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //     ),
            //     onPressed: () {},
            //     child: const Text(
            //       "Create Habit",
            //       style: TextStyle(fontSize: 18, color: Colors.white),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    );
  }

  InputDecoration _inputStyle() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
    );
  }
}
