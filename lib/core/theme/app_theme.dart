import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const bgColor = Color(0xFf000000);
  static const cardColor = Color(0xFF424242);
  static const accentColor = Color(0xFFE50914);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF9B9B9B);
  static const dividerColor = Color(0xFF2C2C2E);

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgColor,
        primaryColor: accentColor,
        colorScheme: const ColorScheme.dark(
          primary: accentColor,
          surface: cardColor,
          background: bgColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bgColor,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: cardColor,
          selectedItemColor: accentColor,
          unselectedItemColor: textSecondary,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              color: textPrimary, fontSize: 26, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
              color: textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              color: textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(
              color: textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: textPrimary, fontSize: 14),
          bodyMedium: TextStyle(color: textSecondary, fontSize: 12),
          labelSmall: TextStyle(color: textSecondary, fontSize: 11),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cardColor,
          hintStyle: const TextStyle(color: textSecondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      );
}
