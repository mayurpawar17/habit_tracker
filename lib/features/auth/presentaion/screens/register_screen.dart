import 'package:flutter/material.dart';
import 'package:habit_tracker/core/theme/app_colors.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPatient = true;
  bool hidePassword = true;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /* Title */
              const Text(
                "Join Habit tracker",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                "Build your habits",
                style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.5),
              ),

              const SizedBox(height: 30),

              /* Inputs */
              AppTextField(
                label: 'Full Name',
                controller: _nameController,
                hint: "John Doe",
              ),

              const SizedBox(height: 8),

              AppTextField(
                label: 'Email Address',
                controller: _nameController,
                hint: "john@example.com",
              ),

              const SizedBox(height: 8),

              AppTextField(
                label: 'Phone Number',
                controller: _nameController,
                hint: "+1 (555) 000-0000",
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 8),

              AppTextField(
                label: 'Password',
                controller: _nameController,
                hint: "••••••••",
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),

              /* Button */
              // _buildCreateButton(),
              AppButton(
                backgroundColor: AppColors.primary,
                onPressed: () {},
                label: "Sign Up",
              ),

              const SizedBox(height: 25),

              /* Sign In */
              _buildSignInText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInText() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already have an account? '),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
