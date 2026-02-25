import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppTextStyle {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const TextStyle heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.textDark,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textDark,
  );
}
