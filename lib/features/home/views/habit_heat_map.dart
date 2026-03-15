import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HabitHeatMap extends StatelessWidget {
  const HabitHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: HeatMap(
          // Your data: DateTime as key, intensity as value
          datasets: {
            DateTime(2026, 3, 1): 10,
            DateTime(2026, 3, 15): 10, // Today!
          },
          colorMode: ColorMode.color,
          defaultColor: Colors.grey[200],
          textColor: Colors.black,
          showColorTip: false,
          // Hides the legend at the bottom
          showText: false,
          // Hides the day numbers inside squares
          scrollable: true,
          size: 15,

          // Size of each square
          colorsets: {
            // 1: Colors.green.shade100,
            // 3: Colors.green.shade300,
            // 5: Colors.green.shade500,
            // 7: Colors.green.shade700,
            // // 10: Colors.green,
            10: Color(0xFF39D353),
          },
          onClick: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("You completed $value habits!")),
            );
          },
        ),
      ),
    );
  }
}
