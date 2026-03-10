import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitFlowUI extends StatelessWidget {
  const HabitFlowUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'HabitFlow',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.blueGrey),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.blueGrey),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProgressCircle(),
            const SizedBox(height: 30),
            _buildGreetingText(),
            const SizedBox(height: 40),
            _buildCalendarTimeline(),
            const SizedBox(height: 30),
            _buildHabitList(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00CBE7),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }

  Widget _buildProgressCircle() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: CircularProgressIndicator(
              value: 0.75,
              strokeWidth: 8,
              backgroundColor: Colors.grey[100],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF00CBE7),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '75',
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '%',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingText() {
    return Column(
      children: [
        Text(
          "Good Morning, Alex",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "6 of 8 habits completed today",
          style: GoogleFonts.poppins(color: Colors.blueGrey[300], fontSize: 16),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F9FC),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "12 DAY STREAK",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: const Color(0xFF1D2235),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarTimeline() {
    return EasyDateTimeLine(
      initialDate: DateTime(2026, 3, 14),
      onDateChange: (selectedDate) {},
      headerProps: const EasyHeaderProps(
        showMonthPicker: false,
        selectedDateStyle: TextStyle(color: Colors.transparent),
      ),
      dayProps: const EasyDayProps(
        height: 80,
        width: 60,
        dayStructure: DayStructure.dayStrDayNum,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Color(0xFF1D2235), // Dark background for active day
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          dayNumStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          dayStrStyle: TextStyle(color: Colors.white, fontSize: 12),
        ),
        inactiveDayStyle: DayStyle(
          dayNumStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          dayStrStyle: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildHabitList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TODAY'S GOALS",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[200],
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          _habitCard(
            "Morning Reading",
            "15 DAY STREAK",
            Icons.menu_book_rounded,
            true,
          ),
          _habitCard("Drink 2L Water", "8 DAY STREAK", Icons.water_drop, false),
          _habitCard(
            "Quick Workout",
            "4 DAY STREAK",
            Icons.fitness_center,
            false,
          ),
          _habitCard(
            "Meditation",
            "22 DAY STREAK",
            Icons.self_improvement,
            false,
          ),
        ],
      ),
    );
  }

  Widget _habitCard(String title, String streak, IconData icon, bool isDone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blueGrey[700]),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDone ? Colors.grey : Colors.black,
                ),
              ),
              Text(
                streak,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00CBE7),
                ),
              ),
            ],
          ),
          const Spacer(),
          isDone
              ? const Icon(
                  Icons.check_circle,
                  color: Color(0xFF90E7F3),
                  size: 30,
                )
              : Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      height: 80,
      notchMargin: 10,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.person, "HOME", true),
          _navItem(Icons.bar_chart, "STATS", false),
          const SizedBox(width: 40),
          _navItem(Icons.emoji_events_outlined, "SOCIAL", false),
          _navItem(Icons.person_outline, "USER", false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.black : Colors.blueGrey[200]),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.black : Colors.blueGrey[200],
          ),
        ),
      ],
    );
  }
}
