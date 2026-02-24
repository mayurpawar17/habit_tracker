import 'package:flutter/material.dart';
import 'package:habit_tracker/core/theme/app_colors.dart';
import 'package:habit_tracker/core/widgets/app_button.dart';
import 'package:habit_tracker/features/home/views/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text(
                'Build healthy habit with ease',
                style: TextStyle(
                  color: AppColors.textLight,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              Image.asset('assets/habit.png'),
              const SizedBox(height: 20),

              const SizedBox(height: 20),
              // const Text(
              //   'Track your habits and make positive changes in your life.',
              //   style: TextStyle(color: AppColors.textLight, fontSize: 16),
              // ),
              const SizedBox(height: 20),
              AppButton(
                label: 'Get Started',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'I have an account',
                style: TextStyle(
                  color: AppColors.textLight,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.textLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
