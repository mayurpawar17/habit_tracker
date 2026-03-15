import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final String label;

  // Optional Icons
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const AppButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor = const Color(0xFFFFFFFF),
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        disabledBackgroundColor: backgroundColor.withOpacity(0.6),
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) ...[
                  Icon(prefixIcon, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                if (suffixIcon != null) ...[
                  const SizedBox(width: 8),
                  Icon(suffixIcon, size: 20),
                ],
              ],
            ),
    );
  }
}
