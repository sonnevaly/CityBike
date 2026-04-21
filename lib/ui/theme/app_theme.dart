import 'package:flutter/material.dart';

// lib/ui/theme/theme.dart
class AppColors {
  static const Color primary = Color(0xFF10B981);
  static const Color alertBlue = Color(0xFFD1E9FF);
  static const Color alertText = Color(0xFF2E90FA);
  static const Color dark = Color(0xFF1F2937);
  static const Color gray = Color(0xFF6B7280);
  static const Color surface = Color(0xFFF9FAFB);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFE5E7EB);
}

// Global Text Styles for easy use
class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.dark,
  );

  static const TextStyle sectionHeader = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.dark,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Work Sans',
    fontSize: 14,
    color: AppColors.gray,
  );

  static const TextStyle emphasizedBody = TextStyle(
    fontFamily: 'Work Sans',
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.dark,
  );
}

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.surface,
  fontFamily: 'Work Sans',
  
  // Customizing the Typography Scale
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontFamily: 'Outfit', fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.dark),
    titleLarge: TextStyle(fontFamily: 'Outfit', fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.dark),
    bodyMedium: TextStyle(fontFamily: 'Work Sans', fontSize: 14, color: AppColors.gray),
    labelLarge: TextStyle(fontFamily: 'Work Sans', fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.dark),
  ),

  // Global Button Style
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontFamily: 'Work Sans', fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),

  // AppBar Style
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(fontFamily: 'Outfit', fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.dark),
    iconTheme: IconThemeData(color: AppColors.dark),
  ),
);