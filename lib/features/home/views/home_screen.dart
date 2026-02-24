import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/theme/app_colors.dart';
import 'package:habit_tracker/features/add_habit/views/add_habit_screen.dart'
    hide AppColors;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeContent(),
    SizedBox(), // Placeholder for Add (handled separately)
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      // ADD BUTTON ACTION
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddHabitLightScreen()),
      );
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: _pages[_selectedIndex],

      ////////////////////////////////////////////////////////////
      /// CUSTOM BOTTOM NAV
      ////////////////////////////////////////////////////////////
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _onItemTapped(0),
                child: Icon(
                  Icons.home,
                  color: _selectedIndex == 0 ? AppColors.purple : Colors.grey,
                ),
              ),

              /// CENTER ADD BUTTON
              GestureDetector(
                onTap: () => _onItemTapped(1),
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: const BoxDecoration(
                    color: AppColors.purple,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),

              GestureDetector(
                onTap: () => _onItemTapped(2),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: _selectedIndex == 2
                      ? AppColors.purple
                      : Colors.grey.shade300,
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// HOME CONTENT (Your existing body moved here)
////////////////////////////////////////////////////////////

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Good morning,", style: GoogleFonts.poppins(fontSize: 16)),
            Text(
              "Mayur",
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  HabitCard(
                    color: AppColors.yellow,
                    title: "Reading",
                    subtitle: "Read 20 pages",
                  ),
                  HabitCard(
                    color: AppColors.pastelGreen,
                    title: "Workout",
                    subtitle: "30 min",
                  ),
                  HabitCard(
                    color: AppColors.blue,
                    title: "Programming",
                    subtitle: "Practice",
                  ),
                  HabitCard(
                    color: AppColors.pink,
                    title: "Finance",
                    subtitle: "Track expenses",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// PROFILE SCREEN (Example)
////////////////////////////////////////////////////////////

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Profile Screen"));
  }
}

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
