import 'package:flutter/material.dart';

class EditHabitSheet extends StatefulWidget {
  const EditHabitSheet({super.key});

  @override
  State<EditHabitSheet> createState() => _EditHabitSheetState();
}

class _EditHabitSheetState extends State<EditHabitSheet> {
  int duration = 15;
  bool isDaily = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Handles keyboard
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          _buildHeader(context),

          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel("HABIT NAME"),
                  _buildNameField(),

                  const SizedBox(height: 25),
                  _sectionLabel("APPEARANCE"),
                  _buildAppearanceTile(),

                  const SizedBox(height: 25),
                  _sectionLabel("SCHEDULE"),
                  _buildScheduleSection(),

                  const SizedBox(height: 25),
                  _sectionLabel("GOAL"),
                  _buildGoalCounter(),

                  const SizedBox(height: 30),
                  // TextButton.icon(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.delete_outline,
                  //     color: Colors.redAccent,
                  //   ),
                  //   label: const Text(
                  //     "Delete Habit",
                  //     style: TextStyle(
                  //       color: Colors.redAccent,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  //
                  // const SizedBox(height: 20),
                  // _buildSaveButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
          const Text(
            "Edit Habit",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(18),
          border: InputBorder.none,
          hintText: "Morning Meditation",
        ),
      ),
    );
  }

  Widget _buildAppearanceTile() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.self_improvement, color: Colors.white),
          ),
          const SizedBox(width: 15),
          const Text(
            "Change Icon & Color",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildScheduleSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.calendar_today, color: Colors.blue),
            title: const Text("Frequency"),
            trailing: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _toggleBtn(
                    "Daily",
                    isDaily,
                    () => setState(() => isDaily = true),
                  ),
                  _toggleBtn(
                    "Weekly",
                    !isDaily,
                    () => setState(() => isDaily = false),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.access_time, color: Colors.blue),
            title: const Text("Reminder Time"),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "07:30 AM",
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Text("Duration", style: TextStyle(fontSize: 16)),
          const Spacer(),
          _circleIconBtn(Icons.remove, () => setState(() => duration--)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "$duration",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _circleIconBtn(Icons.add, () => setState(() => duration++)),
          const SizedBox(width: 10),
          const Text("min", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: Colors.indigo.withOpacity(0.5),
        ),
        onPressed: () {},
        child: const Text(
          "Save Changes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Helper UI Methods
  Widget _sectionLabel(String text) => Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.blueGrey,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
  );

  Widget _toggleBtn(String label, bool active, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: active
                ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.black : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget _circleIconBtn(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: Colors.blue),
    ),
  );
}
