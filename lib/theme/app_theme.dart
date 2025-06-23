import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF8E4162); // Color principal
  static const Color accentColor = Color(0xFFF3E2E6);   // Fondo claro

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: accentColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 16),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}