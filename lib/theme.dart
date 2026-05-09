// lib/theme.dart
import 'package:flutter/material.dart';
class AppTheme {
  static const Color primary = Color(0xFF00E5FF);
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(primary: primary),
  );
}
