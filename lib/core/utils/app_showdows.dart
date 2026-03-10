import 'package:flutter/material.dart';

class AppShadows {
  // 1. Small shadow for subtle lift (e.g., small cards, buttons)
  static const BoxShadow soft = BoxShadow(
    color: Color(0x1A000000), // 10% opacity black
    offset: Offset(0, 2),
    blurRadius: 4,
    spreadRadius: 0,
  );

  // 2. Medium shadow for standard UI elements (e.g., dropdowns, modals)
  static const BoxShadow medium = BoxShadow(
    color: Color(0x26000000), // 15% opacity black
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: -2,
  );

  // 3. Large shadow for floating elements (e.g., FABs, pop-ups)
  static const BoxShadow deep = BoxShadow(
    color: Color(0x33000000), // 20% opacity black
    offset: Offset(0, 10),
    blurRadius: 20,
    spreadRadius: -5,
  );

  // Helper method for custom colored shadows (e.g., branded glow)
  static BoxShadow brandGlow(Color color) {
    return BoxShadow(
      color: color.withOpacity(0.3),
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4,
    );
  }

  // Returns a list to be used directly in BoxDecoration
  static List<BoxShadow> get low => [soft];

  static List<BoxShadow> get elevated => [medium];
}
