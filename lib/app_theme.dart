import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF16A34A);
  static const Color secondary = Color(0xFF34D399);
  static const Color accent = Color(0xFFFBBF24);
  static const Color background = Color(0xFFF3F4F6);
  static const Color darkBg = Color(0xFF111827);

  static const Color gradientStart = Color(0xFF245841);
  static const Color gradientEnd = Color(0xFF299C5B);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    textTheme: GoogleFonts.poppinsTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
  );
}
