import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ─── PUnova Glassmorphism Design System ───────────────────────────

class AppColors {
  // ── Core backgrounds ──
  static const Color bgDark = Color(0xFF0A0E21);
  static const Color bgMedium = Color(0xFF111631);
  static const Color bgCard = Color(0xFF161B33);

  // ── Glass colors ──
  static const Color glassWhite = Color(0x1AFFFFFF); // 10 %
  static const Color glassBorder = Color(0x33FFFFFF); // 20 %
  static const Color glassHighlight = Color(0x0DFFFFFF); // 5 %

  // ── Accents ──
  static const Color accentTeal = Color(0xFF00D2FF);
  static const Color accentCyan = Color(0xFF00F0B5);
  static const Color accentPurple = Color(0xFF7C3AED);
  static const Color accentPink = Color(0xFFEC4899);
  static const Color accentOrange = Color(0xFFFF8C00);
  static const Color accentGreen = Color(0xFF22C55E);
  static const Color accentRed = Color(0xFFEF4444);

  // ── Text ──
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // ── Gradients ──
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [accentTeal, accentCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [accentPurple, accentPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warmGradient = LinearGradient(
    colors: [Color(0xFFFF8C00), Color(0xFFFF5E00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bgGradient = LinearGradient(
    colors: [bgDark, Color(0xFF0D1234), bgMedium],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// Light-mode color overrides — used when user toggles light mode.
class LightColors {
  static const Color bgLight = Color(0xFFF1F5F9);
  static const Color bgMedium = Color(0xFFE2E8F0);
  static const Color bgCard = Color(0xFFFFFFFF);

  static const Color glassWhite = Color(0x1A000000); // 10% black
  static const Color glassBorder = Color(0x1A000000); // 10% black

  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);

  static const LinearGradient bgGradient = LinearGradient(
    colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9), Color(0xFFE2E8F0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// Theme-adaptive color resolver.
/// Usage: `final tc = Tc.of(context);` then `tc.textPrimary`, `tc.bgGradient`, etc.
class Tc {
  final bool isDark;
  Tc.of(BuildContext context)
      : isDark = Theme.of(context).brightness == Brightness.dark;

  Color get textPrimary =>
      isDark ? AppColors.textPrimary : LightColors.textPrimary;
  Color get textSecondary =>
      isDark ? AppColors.textSecondary : LightColors.textSecondary;
  Color get textMuted => isDark ? AppColors.textMuted : LightColors.textMuted;
  Color get bg => isDark ? AppColors.bgDark : LightColors.bgLight;
  Color get bgCard => isDark ? AppColors.bgCard : LightColors.bgCard;
  Color get bgMedium => isDark ? AppColors.bgMedium : LightColors.bgMedium;
  Color get glassWhite =>
      isDark ? AppColors.glassWhite : LightColors.glassWhite;
  Color get glassBorder =>
      isDark ? AppColors.glassBorder : LightColors.glassBorder;
  LinearGradient get bgGradient =>
      isDark ? AppColors.bgGradient : LightColors.bgGradient;
}

class AppTheme {
  // ── Cache font families once to avoid repeated GoogleFonts lookups ──
  static final String? _outfitFamily = GoogleFonts.outfit().fontFamily;
  static final String? _interFamily = GoogleFonts.inter().fontFamily;

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.accentTeal,
      scaffoldBackgroundColor: AppColors.bgDark,
      fontFamily: _outfitFamily,
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: _outfitFamily,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: _outfitFamily,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontFamily: _outfitFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontFamily: _interFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: _interFamily,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        bodyMedium: TextStyle(
          fontFamily: _interFamily,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontFamily: _interFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.accentTeal,
        ),
        labelSmall: TextStyle(
          fontFamily: _interFamily,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.textMuted,
          letterSpacing: 1.2,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentTeal,
        secondary: AppColors.accentPurple,
        surface: AppColors.bgCard,
        error: AppColors.accentRed,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.accentTeal,
      scaffoldBackgroundColor: LightColors.bgLight,
      fontFamily: _outfitFamily,
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontFamily: _outfitFamily,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: LightColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: _outfitFamily,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: LightColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontFamily: _outfitFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: LightColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontFamily: _interFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: LightColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: _interFamily,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: LightColors.textSecondary,
        ),
        bodyMedium: TextStyle(
          fontFamily: _interFamily,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: LightColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontFamily: _interFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.accentTeal,
        ),
        labelSmall: TextStyle(
          fontFamily: _interFamily,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: LightColors.textMuted,
          letterSpacing: 1.2,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.accentTeal,
        secondary: AppColors.accentPurple,
        surface: LightColors.bgCard,
        error: AppColors.accentRed,
      ),
    );
  }
}
