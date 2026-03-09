import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/utils/app_dialog.dart';
import 'package:habit_tracker/features/auth/presentaion/bloc/auth_event.dart';
import 'package:habit_tracker/features/auth/presentaion/bloc/auth_state.dart';
import 'package:habit_tracker/features/home/widgets/habit_tile.dart';

import '../../../core/theme/app_colors.dart';
import '../../auth/data/repo/auth_repo.dart';
import '../../auth/presentaion/bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: const [
              //     Icon(Icons.arrow_back, size: 24),
              //     Text(
              //       "Profile",
              //       style: TextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     Icon(Icons.settings, size: 24),
              //   ],
              // ),
              const SizedBox(height: 30),

              ////////////////////////////////////////////////////////////
              /// PROFILE IMAGE
              ////////////////////////////////////////////////////////////
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/300",
                        ),
                      ),
                    ),

                    /// Edit Button
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2F6BFF),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              ////////////////////////////////////////////////////////////
              /// NAME & EMAIL
              ////////////////////////////////////////////////////////////
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      final user = state.user;
                      print("hello");
                      return Column(
                        children: [
                          Text(
                            state.name ?? "b",
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            user?.email ?? "",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),

              const SizedBox(height: 35),

              ////////////////////////////////////////////////////////////
              /// ACCOUNT SECTION
              ////////////////////////////////////////////////////////////
              sectionTitle("ACCOUNT"),
              const SizedBox(height: 15),

              profileTile(icon: Icons.person, title: "Edit Profile"),

              const SizedBox(height: 15),

              profileTile(icon: Icons.history, title: "My Activity"),

              const SizedBox(height: 30),

              ////////////////////////////////////////////////////////////
              /// SYSTEM SECTION
              ////////////////////////////////////////////////////////////
              sectionTitle("SYSTEM"),
              const SizedBox(height: 15),

              profileTile(
                icon: Icons.tune,
                title: "App Settings",
                subtitle: "Notifications, Privacy",
              ),

              const SizedBox(height: 15),

              profileTile(icon: Icons.help_outline, title: "Help & Support"),

              const SizedBox(height: 25),

              HabitTile(
                title: "Logout",
                icon: Icons.logout,
                onTap: () {
                  AppDialog.showConfirmationDialog(
                    context: context,
                    title: 'Logout',
                    content: 'Are you sure? \ndo you want to Logout',
                    confirmText: 'Yes',
                    cancelText: 'No',
                    confirmColor: Colors.green,
                    onConfirm: () {
                      context.read<AuthBloc>().add(LogoutRequested());
                    },
                  );
                  // _authService.logout();
                },
                isDone: false,
                onChanged: (bool? value) {},
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  /// SECTION TITLE
  ////////////////////////////////////////////////////////////

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: Colors.grey,
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  /// PROFILE TILE
  ////////////////////////////////////////////////////////////

  Widget profileTile({
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 6),
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9EEF9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF2F6BFF)),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
