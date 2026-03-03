import 'package:flutter/material.dart';

class AppSnackbar {
  /// Displays a customizable snackbar.
  /// Standardizes the look for Success, Error, and Info messages.
  static void show(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.amber, // Your habit green
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: duration,
      ),
    );
  }

  /// Shortcut for Success messages
  static void success(BuildContext context, String message) {
    show(
      context,
      message: message,
      backgroundColor: const Color(0xFF4CAF50), // Hex: #4CAF50
      icon: Icons.check_circle_outline,
    );
  }

  /// Shortcut for Error messages
  static void error(BuildContext context, String message) {
    show(
      context,
      message: message,
      backgroundColor: Colors.redAccent,
      icon: Icons.error_outline,
    );
  }
}
