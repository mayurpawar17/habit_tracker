import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/auth/presentaion/bloc/auth_event.dart';
import 'package:habit_tracker/features/auth/presentaion/bloc/auth_state.dart';
import 'package:habit_tracker/features/auth/presentaion/screens/register_screen.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/repo/auth_repo.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  final AuthService _authService = AuthService();
  bool isLoading = false;

  // Future<void> _loginUser() async {
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();
  //
  //   if (email.isEmpty || password.isEmpty) {
  //     AppSnackbar.error(context, "Please enter email and password");
  //     // _showMessage("Please enter email and password");
  //     return;
  //   }
  //
  //   try {
  //     setState(() => isLoading = true);
  //
  //     final user = await _authService.login(email: email, password: password);
  //
  //     if (user != null) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (_) => HomeScreen()),
  //       );
  //     }
  //   } catch (e) {
  //     AppSnackbar.error(context, e.toString());
  //     // _showMessage(e.toString());
  //   } finally {
  //     setState(() => isLoading = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// App Title
                    Text(
                      'Habit tracker',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Medical Icon Box
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.local_hospital_rounded,
                        color: Color(0xFF4A90E2),
                        size: 40,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Welcome Text
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // const Text(
                    //   "Access your medical records and coordinate with\n"
                    //   "your healthcare team securely.",
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(fontSize: 15, color: Colors.grey),
                    // ),
                    const SizedBox(height: 40),

                    /// Email Label

                    /// Email Field
                    AppTextField(
                      label: 'Email Address',
                      controller: emailController,
                      hint: 'name@example.com',
                    ),

                    const SizedBox(height: 25),

                    /// Password Label
                    // const Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     "PASSWORD",
                    //     style: TextStyle(
                    //       fontSize: 12,
                    //       letterSpacing: 1.2,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.grey,
                    //     ),
                    //   ),
                    // ),
                    AppTextField(
                      label: 'Password',
                      controller: passwordController,
                      hint: 'Enter password',
                    ),

                    const SizedBox(height: 10),

                    /// Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(color: Color(0xFF4A90E2)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Login Button
                    AppButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          LoginRequested(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          ),
                        );
                      },
                      label: isLoading ? 'Loading...' : 'Login',
                    ),
                    const SizedBox(height: 30),

                    /// Sign Up Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xFF4A90E2),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
