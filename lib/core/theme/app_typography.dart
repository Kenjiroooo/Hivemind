import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static final TextStyle headlineSm = GoogleFonts.plusJakartaSans(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle bodySm = GoogleFonts.inter(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle displayLg = GoogleFonts.plusJakartaSans(
    fontSize: 48,
    height: 56 / 48,
    letterSpacing: -48 * 0.02,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle bodyLg = GoogleFonts.inter(
    fontSize: 18,
    height: 28 / 18,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle headlineLg = GoogleFonts.plusJakartaSans(
    fontSize: 32,
    height: 40 / 32,
    letterSpacing: -32 * 0.01,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle headlineLgMobile = GoogleFonts.plusJakartaSans(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle bodyMd = GoogleFonts.inter(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle labelMd = GoogleFonts.inter(
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 12 * 0.05,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle headlineMd = GoogleFonts.plusJakartaSans(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w600,
  );
  
  static TextTheme getTextTheme() {
    return TextTheme(
      displayLarge: displayLg,
      headlineLarge: headlineLg,
      headlineMedium: headlineMd,
      headlineSmall: headlineSm,
      bodyLarge: bodyLg,
      bodyMedium: bodyMd,
      bodySmall: bodySm,
      labelLarge: labelMd,
      labelMedium: labelMd,
    );
  }
}
