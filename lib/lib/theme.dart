import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ডায়নামিক কালার স্কিম (মার্কো অ্যাপেক্স + জার্ভিস)
  static const Color primary = Color(0xFF00E5FF);
  static const Color secondary = Color(0xFF7C4DFF);
  static const Color accent = Color(0xFF00E676);
  static const Color background = Color(0xFF0A0E21);
  static const Color surface = Color(0xFF1D1E33);
  static const Color error = Color(0xFFFF5252);

  // গ্লাসমর্ফিজম ইফেক্ট স্ট্যান্ডার্ড
  static BoxDecoration glassDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.white.withOpacity(0.08), Colors.white.withOpacity(0.02)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.white.withOpacity(0.1)),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 20,
        offset: Offset(0, 10),
      ),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      surface: surface,
      background: background,
      error: error,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: background,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
      bodyLarge: const TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface.withOpacity(0.4),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.orbitron(
        color: primary,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surface.withOpacity(0.6),
      selectedItemColor: primary,
      unselectedItemColor: Colors.white38,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
    cardTheme: CardTheme(
      color: surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white70),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? accent : Colors.grey),
      trackColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? accent.withOpacity(0.5) : Colors.grey.withOpacity(0.3)),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surface,
      contentTextStyle: const TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  // গ্লাস বাবল (চ্যাটের জন্য)
  static BoxDecoration glassBubble(bool isUser) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: isUser
            ? [primary.withOpacity(0.3), secondary.withOpacity(0.2)]
            : [Colors.white.withOpacity(0.12), Colors.white.withOpacity(0.06)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(22),
        topRight: const Radius.circular(22),
        bottomLeft: Radius.circular(isUser ? 22 : 6),
        bottomRight: Radius.circular(isUser ? 6 : 22),
      ),
      border: Border.all(
        color: isUser ? primary.withOpacity(0.4) : Colors.white.withOpacity(0.08),
      ),
      boxShadow: [
        BoxShadow(
          color: (isUser ? primary : Colors.black).withOpacity(0.2),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  // নিওন গ্লো টেক্সট স্টাইল
  static TextStyle neonGlow(Color color, {double fontSize = 16}) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(color: color.withOpacity(0.8), blurRadius: 15),
      ],
    );
  }
}
