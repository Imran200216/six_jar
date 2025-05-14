import 'package:flutter/material.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    textTheme: TextTheme(
      // headline large
      headlineLarge: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
      ),

      // headline small
      headlineSmall: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
