import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback onDelete; // Added delete callback
  final Color color;
  final Color? backgroundColor;

  const HabitTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.onDelete,
    this.color = Colors.red,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: ListTile(
        onTap: onTap,
        // Mimicking your exact Container decoration
        tileColor: backgroundColor ?? color.withOpacity(0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // Matching your 18px horizontal padding
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),

        leading: Icon(icon, color: color),

        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),

        // Trailing section with Delete and Arrow
        trailing: Wrap(
          spacing: 8, // Space between delete icon and arrow
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
              color: Colors.redAccent,
              visualDensity: VisualDensity.compact,
            ),
            // Icon(
            //   Icons.arrow_forward_ios,
            //   size: 16,
            //   color: color.withOpacity(0.6),
            // ),
          ],
        ),
      ),
    );
  }
}
