import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF10B981);
  static const Color teal = Color(0xFF0D9488);
  static const Color dark = Color(0xFF1F2937);
  static const Color gray = Color(0xFF6B7280);
  static const Color surface = Color(0xFFF9FAFB);
  static const Color white = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFEF4444);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.surface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),

      // Local Fonts from pubspec.yaml
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.dark,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.dark,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Work Sans',
          fontSize: 14,
          color: AppColors.gray,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Work Sans',
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.dark,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontFamily: 'Work Sans', fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}