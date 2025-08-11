import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryPink = Color(0xFFE91E63);
  static const Color lightPink = Color(0xFFF8BBD9);
  static const Color darkPink = Color(0xFFAD1457);
  static const Color purple = Color(0xFF9C27B0);
  static const Color lightPurple = Color(0xFFE1BEE7);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFAFAFA);
  static const Color darkGray = Color(0xFF121212);
  static const Color lightGray = Color(0xFF757575);
  static const Color mediumGray = Color(0xFF424242);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryPink,
    scaffoldBackgroundColor: offWhite,
    colorScheme: const ColorScheme.light(
      primary: primaryPink,
      secondary: purple,
      surface: white,
      onPrimary: white,
      onSecondary: white,
      onSurface: darkGray,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: darkGray,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: darkGray,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: darkGray,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: darkGray,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: lightGray,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryPink,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: lightPink),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: lightPink),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: primaryPink, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    cardTheme: CardThemeData(
      color: white,
      elevation: 4,
      shadowColor: lightPink.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: white,
      elevation: 0,
      iconTheme: const IconThemeData(color: darkGray),
      titleTextStyle: GoogleFonts.poppins(
        color: darkGray,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryPink,
    scaffoldBackgroundColor: darkGray,
    colorScheme: const ColorScheme.dark(
      primary: primaryPink,
      secondary: lightPurple,
      surface: mediumGray,
      onPrimary: white,
      onSecondary: darkGray,
      onSurface: white,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: white,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: white,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: white,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: white,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.grey[300],
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryPink,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: mediumGray,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: lightGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: lightGray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: primaryPink, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    cardTheme: CardThemeData(
      color: mediumGray,
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkGray,
      elevation: 0,
      iconTheme: const IconThemeData(color: white),
      titleTextStyle: GoogleFonts.poppins(
        color: white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
