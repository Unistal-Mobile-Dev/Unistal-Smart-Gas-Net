import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(Color primary) =>
      _buildLightTheme(primary);

  static ThemeData darkTheme(Color primary) =>
      _buildDarkTheme(primary);

  // ================= LIGHT =================
  static ThemeData _buildLightTheme(Color primary) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primary,
      scaffoldBackgroundColor: const Color(0xffF5F7FB),

      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: const Color(0xff00BFA6),
        error: const Color(0xffE53935),
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),

      iconTheme: IconThemeData(color: primary),
    );
  }

  // ================= DARK =================
  static ThemeData _buildDarkTheme(Color primary) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primary,
      scaffoldBackgroundColor: const Color(0xff0F172A),

      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: const Color(0xff00E5C1),
        error: const Color(0xffFF6B6B),
      ),

      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0xff111827),
        foregroundColor: Colors.white,
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        color: const Color(0xff1E293B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xff1E293B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}