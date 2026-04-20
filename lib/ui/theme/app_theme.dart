import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF10B981); // Your Velo Green
  static const Color dark = Color(0xFF1F2937);
  static const Color gray = Color(0xFF6B7280);
  static const Color surface = Color(0xFFF9FAFB);
}

// Your specific Design System (Part 1 of Evaluation)
ThemeData appTheme = ThemeData(
  useMaterial3: true,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.surface,
  
  // Use YOUR fonts from pubspec.yaml, NOT your friend's 'Inter'
  fontFamily: 'Work Sans', 
  
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontFamily: 'Outfit', fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.dark),
    titleLarge: TextStyle(fontFamily: 'Outfit', fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.dark),
    bodyMedium: TextStyle(fontFamily: 'Work Sans', fontSize: 14, color: AppColors.gray),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);