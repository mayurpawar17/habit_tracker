import 'package:flutter/material.dart';
import 'package:habit_tracker/core/theme/app_colors.dart';
import 'package:habit_tracker/features/add_habit/views/add_habit_screen.dart'
    hide AppColors;
import 'package:habit_tracker/features/home/views/dashboard_screen.dart';
import 'package:habit_tracker/features/home/views/home_screen.dart';
import 'package:habit_tracker/features/profile/views/profile_screen.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    // AddHabitLightScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(child: _screens[_currentIndex]),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },

        height: 72,
        backgroundColor: AppColors.textLight,
        indicatorColor: AppColors.primary.withOpacity(0.15),

        destinations: [
          const NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              color: AppColors.primary,
            ),
            label: 'Home',
          ),
          // NavigationDestination(
          //   icon: HugeIcon(icon: HugeIcons.strokeRoundedAdd01),
          //   selectedIcon: HugeIcon(
          //     icon: HugeIcons.strokeRoundedAdd01,
          //     color: AppColors.primary,
          //   ),
          //   label: 'Add Habit',
          // ),
          // const NavigationDestination(
          //   icon: HugeIcon(icon: HugeIcons.strokeRoundedStars),
          //   selectedIcon: HugeIcon(
          //     icon: HugeIcons.strokeRoundedStars,
          //     color: AppColors.primary,
          //   ),
          //   label: 'AI Chat',
          // ),
          const NavigationDestination(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedSettings01),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedSettings01,
              color: AppColors.primary,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
