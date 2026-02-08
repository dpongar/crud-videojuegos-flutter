import 'package:flutter/material.dart';

class AppTheme {

  static const Color primaryNeon = Color(0xFF6366F1); 
  static const Color secondaryNeon = Color(0xFF06B6D4); 
  static const Color backgroundDark = Color(0xFF0F172A); 
  static const Color surfaceDark = Color(0xFF1E293B); 

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primaryNeon,
      secondary: secondaryNeon,
      surface: surfaceDark,
      background: backgroundDark,
      onPrimary: Colors.white,
    ),
    scaffoldBackgroundColor: backgroundDark,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: backgroundDark,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        color: Colors.white,
      ),
    ),


    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.white10, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryNeon, width: 2),
      ),
      labelStyle: const TextStyle(color: Colors.white70),
    ),


    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryNeon,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryNeon,
      foregroundColor: backgroundDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    ),
  );
}