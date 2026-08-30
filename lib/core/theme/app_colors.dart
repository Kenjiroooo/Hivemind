import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Core Brand Colors - Vibrant, Electric feel
  static const Color primary = Color(0xFF4F46E5); // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF3730A3);
  static const Color onPrimary = Colors.white;

  static const Color secondary = Color(0xFFEC4899); // Pink
  static const Color secondaryLight = Color(0xFFF472B6);
  static const Color onSecondary = Colors.white;

  static const Color accent = Color(0xFF06B6D4); // Cyan

  // Surface & Background Colors
  static const Color background = Color(0xFFF8FAFC); // Very light slate
  static const Color surface = Colors.white;
  static const Color surfaceContainerLow = Color(0xFFF1F5F9);
  static const Color surfaceContainerHighest = Color(0xFFE2E8F0);
  
  static const Color onSurface = Color(0xFF0F172A); // Slate 900
  static const Color onSurfaceVariant = Color(0xFF64748B); // Slate 500

  // Outlines & Dividers
  static const Color outline = Color(0xFF94A3B8);
  static const Color outlineVariant = Color(0xFFE2E8F0);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  
  // Custom Gradient (To be used in BoxDecoration)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF8FAFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Legacy mappings for backwards compatibility while migrating
  static const Color primaryContainer = Color(0xFFEEF2FF);
  static const Color onPrimaryContainer = Color(0xFF3730A3);
  static const Color secondaryContainer = Color(0xFFFCE7F3);
  static const Color onSecondaryContainer = Color(0xFFBE185D);
  static const Color tertiary = Color(0xFF8B5CF6);
  static const Color onTertiary = Colors.white;
  static const Color tertiaryContainer = Color(0xFFF5F3FF);
  static const Color onTertiaryContainer = Color(0xFF6D28D9);
  static const Color errorContainer = Color(0xFFFEF2F2);
  static const Color onErrorContainer = Color(0xFFB91C1C);
  static const Color inverseSurface = Color(0xFF1E293B);
  static const Color inverseOnSurface = Color(0xFFF1F5F9);
  static const Color inversePrimary = Color(0xFFA5B4FC);
  static const Color onError = Colors.white;
  static const Color surfaceContainerHigh = Color(0xFFE2E8F0);
  static const Color surfaceVariant = Color(0xFFE2E8F0);
}
