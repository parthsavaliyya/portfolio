import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // ── Dark mode backgrounds ──────────────────────────────
  static const darkBackground = Color(0xFF0F0F0F);
  static const darkSurface = Color(0xFF202020);
  static const darkCard = Color(0xFF202020);

  // ── Light mode backgrounds ─────────────────────────────
  static const lightBackground = Color(0xFFF8F8F8);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFFFFFFF);

  // ── Brand accent greens ────────────────────────────────
  static const green = Color(0xFF54C5F8); // primary accent
  static const darkGreen = Color(0xFF01579B); // hover / dark variant

  // ── Keep old names as aliases so no widget breaks ─────
  static const cyan = Color(0xFF54C5F8); // → green
  static const purple = Color(0xFF01579B); // → dark green
  static const neonGreen = Color(0xFF54C5F8);
  static const amber = Color(0xFF54C5F8); // resume button
  static const pink = Color(0xFF54C5F8);

  // ── Gradient ───────────────────────────────────────────
  static const gradientStart = Color(0xFF54C5F8);
  static const gradientEnd = Color(0xFF01579B);

  // ── Glass surfaces ─────────────────────────────────────
  static const darkGlass = Color(0x28FFFFFF); // white 16%
  static const lightGlass = Color(0xCCFFFFFF); // white 80%
  static const glassBorder = Color(0x33FFFFFF);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.darkSurface,
        primary: AppColors.green,
        secondary: AppColors.darkGreen,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      iconTheme: const IconThemeData(color: AppColors.green),
      extensions: const [PortfolioColors.dark],
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        surface: AppColors.lightSurface,
        primary: AppColors.green,
        secondary: AppColors.darkGreen,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      iconTheme: const IconThemeData(color: AppColors.darkGreen),
      extensions: const [PortfolioColors.light],
    );
  }
}

class PortfolioColors extends ThemeExtension<PortfolioColors> {
  final Color accent1;
  final Color accent2;
  final Color cardBg;
  final Color glassColor;
  final Color textPrimary;
  final Color textSecondary;

  const PortfolioColors({
    required this.accent1,
    required this.accent2,
    required this.cardBg,
    required this.glassColor,
    required this.textPrimary,
    required this.textSecondary,
  });

  static const dark = PortfolioColors(
    accent1: AppColors.green,
    accent2: AppColors.darkGreen,
    cardBg: AppColors.darkCard,
    glassColor: AppColors.darkGlass,
    textPrimary: Colors.white,
    textSecondary: Color(0xFFB0BEC5),
  );

  static const light = PortfolioColors(
    accent1: AppColors.green,
    accent2: AppColors.darkGreen,
    cardBg: AppColors.lightCard,
    glassColor: AppColors.lightGlass,
    textPrimary: Color(0xFF0F0F0F),
    textSecondary: Color(0xFF546E7A),
  );

  @override
  PortfolioColors copyWith({
    Color? accent1,
    Color? accent2,
    Color? cardBg,
    Color? glassColor,
    Color? textPrimary,
    Color? textSecondary,
  }) {
    return PortfolioColors(
      accent1: accent1 ?? this.accent1,
      accent2: accent2 ?? this.accent2,
      cardBg: cardBg ?? this.cardBg,
      glassColor: glassColor ?? this.glassColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  PortfolioColors lerp(ThemeExtension<PortfolioColors>? other, double t) {
    if (other is! PortfolioColors) return this;
    return PortfolioColors(
      accent1: Color.lerp(accent1, other.accent1, t)!,
      accent2: Color.lerp(accent2, other.accent2, t)!,
      cardBg: Color.lerp(cardBg, other.cardBg, t)!,
      glassColor: Color.lerp(glassColor, other.glassColor, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}
