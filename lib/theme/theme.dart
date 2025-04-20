import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColorLight = Color(0xFF3949AB); // Indigo
  static const Color secondaryColorLight = Color(0xFF00897B); // Teal
  static const Color accentColorLight = Color(0xFFFF5722); // Deep Orange
  static const Color backgroundColorLight = Color(0xFFF5F5F5);
  static const Color surfaceColorLight = Colors.white;
  static const Color textColorLight = Color(0xFF212121);
  
  static const Color primaryColorDark = Color(0xFF5C6BC0); // Lighter Indigo
  static const Color secondaryColorDark = Color(0xFF26A69A); // Lighter Teal
  static const Color accentColorDark = Color(0xFFFF8A65); // Lighter Deep Orange
  static const Color backgroundColorDark = Color(0xFF121212);
  static const Color surfaceColorDark = Color(0xFF1E1E1E);
  static const Color textColorDark = Color(0xFFEEEEEE);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryColorLight,
      secondary: secondaryColorLight,
      tertiary: accentColorLight,
      background: backgroundColorLight,
      surface: surfaceColorLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      onBackground: textColorLight,
      onSurface: textColorLight,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceColorLight,
      foregroundColor: textColorLight,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: surfaceColorLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(color: textColorLight, fontWeight: FontWeight.bold),
      displayMedium: GoogleFonts.montserrat(color: textColorLight, fontWeight: FontWeight.bold),
      displaySmall: GoogleFonts.montserrat(color: textColorLight, fontWeight: FontWeight.bold),
      headlineLarge: GoogleFonts.montserrat(color: textColorLight, fontWeight: FontWeight.w700),
      headlineMedium: GoogleFonts.montserrat(color: textColorLight, fontWeight: FontWeight.w700),
      headlineSmall: GoogleFonts.montserrat(color: textColorLight, fontWeight: FontWeight.w700),
      titleLarge: GoogleFonts.montserrat(color: textColorLight, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.montserrat(color: textColorLight, fontWeight: FontWeight.w600),
      titleSmall: GoogleFonts.montserrat(color: textColorLight, fontWeight: FontWeight.w600),
      bodyLarge: GoogleFonts.lato(color: textColorLight),
      bodyMedium: GoogleFonts.lato(color: textColorLight),
      bodySmall: GoogleFonts.lato(color: textColorLight),
      labelLarge: GoogleFonts.lato(color: textColorLight, fontWeight: FontWeight.w500),
      labelMedium: GoogleFonts.lato(color: textColorLight, fontWeight: FontWeight.w500),
      labelSmall: GoogleFonts.lato(color: textColorLight, fontWeight: FontWeight.w500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorLight,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColorLight,
        side: BorderSide(color: primaryColorLight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColorLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    iconTheme: IconThemeData(color: primaryColorLight),
    chipTheme: ChipThemeData(
      backgroundColor: backgroundColorLight,
      selectedColor: primaryColorLight,
      labelStyle: GoogleFonts.lato(color: textColorLight),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryColorDark,
      secondary: secondaryColorDark,
      tertiary: accentColorDark,
      background: backgroundColorDark,
      surface: surfaceColorDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      onBackground: textColorDark,
      onSurface: textColorDark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceColorDark,
      foregroundColor: textColorDark,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: surfaceColorDark,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(color: textColorDark, fontWeight: FontWeight.bold),
      displayMedium: GoogleFonts.montserrat(color: textColorDark, fontWeight: FontWeight.bold),
      displaySmall: GoogleFonts.montserrat(color: textColorDark, fontWeight: FontWeight.bold),
      headlineLarge: GoogleFonts.montserrat(color: textColorDark, fontWeight: FontWeight.w700),
      headlineMedium: GoogleFonts.montserrat(color: textColorDark, fontWeight: FontWeight.w700),
      headlineSmall: GoogleFonts.montserrat(color: textColorDark, fontWeight: FontWeight.w700),
      titleLarge: GoogleFonts.montserrat(color: textColorDark, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.montserrat(color: textColorDark, fontWeight: FontWeight.w600),
      titleSmall: GoogleFonts.montserrat(color: textColorDark, fontWeight: FontWeight.w600),
      bodyLarge: GoogleFonts.lato(color: textColorDark),
      bodyMedium: GoogleFonts.lato(color: textColorDark),
      bodySmall: GoogleFonts.lato(color: textColorDark),
      labelLarge: GoogleFonts.lato(color: textColorDark, fontWeight: FontWeight.w500),
      labelMedium: GoogleFonts.lato(color: textColorDark, fontWeight: FontWeight.w500),
      labelSmall: GoogleFonts.lato(color: textColorDark, fontWeight: FontWeight.w500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorDark,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColorDark,
        side: BorderSide(color: primaryColorDark),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColorDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
    iconTheme: IconThemeData(color: primaryColorDark),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceColorDark,
      selectedColor: primaryColorDark,
      labelStyle: GoogleFonts.lato(color: textColorDark),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}