import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isDone; // Track completion state
  final VoidCallback onTap;
  final ValueChanged<bool?> onChanged; // Callback for the checkbox
  final Color color;
  final Color? backgroundColor;

  const HabitTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isDone,
    required this.onChanged,
    this.color = Colors.red,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: onTap,
        tileColor: backgroundColor ?? color.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

        // Leading Icon
        leading: Icon(icon, color: color),

        // Habit Title
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            // Optional: Strike through text if habit is done
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),

        // Circular Checkbox
        trailing: Transform.scale(
          scale: 1.2, // Makes the checkbox slightly larger to match the UI
          child: Checkbox(
            value: isDone,
            onChanged: onChanged,
            activeColor: color,
            checkColor: Colors.white,
            shape: const CircleBorder(), // Makes the checkbox circular
            side: BorderSide(color: color.withOpacity(0.4), width: 2),
          ),
        ),
      ),
    );
  }
}
