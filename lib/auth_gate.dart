import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/widgets/app_loader.dart';

import 'features/auth/presentaion/bloc/auth_bloc.dart';
import 'features/auth/presentaion/bloc/auth_state.dart';
import 'features/auth/presentaion/screens/login_screen.dart';
import 'features/home/views/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: AppLoader()),
          );
        }

        if (state is Authenticated) {
          return const HomeScreen();
        }

        return const LoginScreen();
      },
    );
  }
}
