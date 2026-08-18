import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortfolioTheme {
  // Brand Palette - Cyber Dark (Primary)
  static const Color darkBg = Color(0xFF0A0E1A);
  static const Color darkSurface = Color(0xFF121829);
  static const Color darkCard = Color(0xFF182035);
  static const Color darkCardHover = Color(0xFF222C47);
  static const Color darkBorder = Color(0xFF2A3655);

  // Brand Palette - Aurora Light
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF1F5F9);
  static const Color lightCardHover = Color(0xFFE2E8F0);
  static const Color lightBorder = Color(0xFFCBD5E1);

  // Vibrant Accents & Gradients
  static const Color primaryCyan = Color(0xFF00F2FE);
  static const Color primaryIndigo = Color(0xFF4FACFE);
  static const Color accentViolet = Color(0xFF7F00FF);
  static const Color accentPurple = Color(0xFFE100FF);
  static const Color accentEmerald = Color(0xFF00F5A0);
  static const Color accentAmber = Color(0xFFFFB300);
  static const Color accentRose = Color(0xFFFF4B72);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryCyan, primaryIndigo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient violetGradient = LinearGradient(
    colors: [accentViolet, accentPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient emeraldGradient = LinearGradient(
    colors: [accentEmerald, primaryCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const RadialGradient heroGlowGradient = RadialGradient(
    colors: [Color(0x3300F2FE), Color(0x1A7F00FF), Colors.transparent],
    radius: 0.8,
  );

  // Glassmorphic Card Decoration
  static BoxDecoration glassBoxDecoration({
    required bool isDark,
    double radius = 20,
    Color? borderColor,
    Color? customBg,
    bool hasGlow = false,
  }) {
    return BoxDecoration(
      color: customBg ??
          (isDark
              ? darkCard.withValues(alpha: 0.7)
              : lightSurface.withValues(alpha: 0.85)),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: borderColor ??
            (isDark
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.black.withValues(alpha: 0.08)),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withValues(alpha: 0.4)
              : Colors.blueGrey.withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
        if (hasGlow)
          BoxShadow(
            color: primaryCyan.withValues(alpha: 0.2),
            blurRadius: 30,
            spreadRadius: -5,
          ),
      ],
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    final textTheme = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: primaryCyan,
      colorScheme: const ColorScheme.dark(
        primary: primaryCyan,
        secondary: primaryIndigo,
        tertiary: accentViolet,
        surface: darkSurface,
        error: accentRose,
      ),
      textTheme: textTheme.copyWith(
        displayLarge: GoogleFonts.outfit(
          fontSize: 54,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -1.2,
          height: 1.1,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: -0.8,
        ),
        displaySmall: GoogleFonts.outfit(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF94A3B8),
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF64748B),
          height: 1.5,
        ),
      ),
    );
  }

  // Light Theme
  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.interTextTheme(ThemeData.light().textTheme);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      primaryColor: const Color(0xFF2563EB),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF2563EB),
        secondary: Color(0xFF0284C7),
        tertiary: Color(0xFF7C3AED),
        surface: lightSurface,
        error: accentRose,
      ),
      textTheme: textTheme.copyWith(
        displayLarge: GoogleFonts.outfit(
          fontSize: 54,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF0F172A),
          letterSpacing: -1.2,
          height: 1.1,
        ),
        displayMedium: GoogleFonts.outfit(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F172A),
          letterSpacing: -0.8,
        ),
        displaySmall: GoogleFonts.outfit(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F172A),
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0F172A),
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0F172A),
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF475569),
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF64748B),
          height: 1.5,
        ),
      ),
    );
  }
}

class ResponsiveBreakpoints {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1100;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double contentPadding(BuildContext context) {
    if (isMobile(context)) return 20.0;
    if (isTablet(context)) return 40.0;
    return 80.0;
  }
}
