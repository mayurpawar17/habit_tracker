import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;

  const HabitCard({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 6),
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.book),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Text(subtitle, style: GoogleFonts.poppins(fontSize: 13)),
        ],
      ),
    );
  }
}
