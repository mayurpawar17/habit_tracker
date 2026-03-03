import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/repo/auth_repo.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false;

  final AuthService _authService = AuthService();

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

              /// Title
              const Text(
                "Join Habit Tracker",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                "Build your habits",
                style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.5),
              ),

              const SizedBox(height: 30),

              /// Name
              AppTextField(
                label: 'Full Name',
                controller: _nameController,
                hint: "John Doe",
              ),

              const SizedBox(height: 12),

              /// Email
              AppTextField(
                label: 'Email Address',
                controller: _emailController,
                hint: "john@example.com",
              ),

              const SizedBox(height: 12),

              /// Password
              AppTextField(
                label: 'Password',
                controller: _passwordController,
                hint: "••••••••",
                // obscureText: true,
              ),

              const SizedBox(height: 24),

              /// Sign Up Button
              AppButton(
                backgroundColor: AppColors.primary,
                onPressed: isLoading ? null : _registerUser,
                label: isLoading ? "Creating..." : "Sign Up",
              ),

              const SizedBox(height: 25),

              /// Login Text
              _buildSignInText(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= REGISTER LOGIC =================

  Future<void> _registerUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage("All fields are required");
      return;
    }

    if (password.length < 6) {
      _showMessage("Password must be at least 6 characters");
      return;
    }

    try {
      setState(() => isLoading = true);
      _authService.register(name: name, email: email, password: password);
      // // 1️⃣ Create user in Firebase Auth
      // final result = await _auth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      //
      // final uid = result.user!.uid;
      //
      // // 2️⃣ Create user in Firestore
      // await _firestore.collection('users').doc(uid).set({
      //   'name': name,
      //   'email': email,
      //   'createdAt': Timestamp.now(),
      //   'isPremium': false,
      // });

      // 3️⃣ Go to Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String msg = "Registration failed";

      if (e.code == 'email-already-in-use') {
        msg = "Email already registered";
      } else if (e.code == 'invalid-email') {
        msg = "Invalid email";
      } else if (e.code == 'weak-password') {
        msg = "Weak password";
      }

      _showMessage(msg);
    } catch (e) {
      _showMessage("Something went wrong");
    } finally {
      setState(() => isLoading = false);
    }
  }

  // ================= UI HELPERS =================

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
                MaterialPageRoute(builder: (_) => const LoginScreen()),
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
