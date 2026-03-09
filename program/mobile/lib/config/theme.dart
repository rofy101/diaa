import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF4A90D9);
  static const Color primaryGreen = Color(0xFF66BB6A);
  static const Color primaryOrange = Color(0xFFFFA726);
  static const Color backgroundColor = Color(0xFFF5F7FA);
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color errorColor = Color(0xFFE57373);
  static const Color successColor = Color(0xFF81C784);

  static TextTheme get arabicTextTheme => GoogleFonts.cairoTextTheme();

  static ThemeData get lightTheme => ThemeData(
        primaryColor: primaryBlue,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),
        scaffoldBackgroundColor: backgroundColor,
        textTheme: arabicTextTheme.copyWith(
          headlineLarge: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: textPrimary),
          headlineMedium: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: textPrimary),
          bodyLarge: const TextStyle(fontSize: 20, color: textPrimary),
          bodyMedium: const TextStyle(fontSize: 18, color: textPrimary),
          labelLarge: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.all(8),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle:
              GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      );
}
