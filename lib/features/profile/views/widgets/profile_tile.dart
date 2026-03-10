import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/app_showdows.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isDone; // Track completion state
  final VoidCallback onTap;
  final ValueChanged<bool?> onChanged; // Callback for the checkbox
  final Color color;
  final Color? backgroundColor;

  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isDone,
    required this.onChanged,
    this.color = Colors.white,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
        boxShadow: [AppShadows.soft],
      ),
      child: ListTile(
        onTap: onTap,
        tileColor: backgroundColor ?? color.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

        // Leading Icon
        // leading: Icon(icon, color: AppColors.primary),
        leading: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFE9EEF9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF2F6BFF)),
        ),

        // Habit Title
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            // Optional: Strike through text if habit is done
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
        ),

        // Circular Checkbox
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
