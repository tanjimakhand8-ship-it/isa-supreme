import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color matrixGreen = Color(0xFF00FF41);
  static const Color bgDark = Color(0xFF050505);
  static const Color surface = Color(0xFF0F0F0F);
  static const Color border = Color(0xFF1A1A1A);

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: bgDark,
    colorScheme: const ColorScheme.dark(primary: matrixGreen),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: matrixGreen,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontFamily: 'JetBrains Mono',
      ),
    ),
    textTheme: GoogleFonts.jetBrainsMonoTextTheme(ThemeData.dark().textTheme),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: matrixGreen.withOpacity(0.5)),
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: matrixGreen),
      ),
    ),
  );
}
