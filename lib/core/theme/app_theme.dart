import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/theme/app_text_styles.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    scaffoldBackgroundColor: AppColors.background,
    useMaterial3: true,
    textTheme: TextTheme(bodyMedium: AppTextStyles.medium).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),
  );
}
