import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary - Sage Green (calm, nature, trust)
  static const Color primary = Color(0xFF6B8E6B);
  static const Color primaryLight = Color(0xFF8BAF8B);
  static const Color primaryDark = Color(0xFF4A6B4A);
  static const Color primarySurface = Color(0xFFEDF3ED);

  // Accent - Warm Sand (elegance, warmth)
  static const Color accent = Color(0xFFD4B896);
  static const Color accentLight = Color(0xFFE8D5BE);
  static const Color accentDark = Color(0xFFB89B74);

  // Gradients
  static const List<Color> gradientPrimary = [
    Color(0xFF6B8E6B),
    Color(0xFF8BAF8B),
  ];
  static const List<Color> gradientAccent = [
    Color(0xFFD4B896),
    Color(0xFFE8D5BE),
  ];
  static const List<Color> gradientWarm = [
    Color(0xFFF7F5F2),
    Color(0xFFFFFFFF),
  ];

  // Semantic
  static const Color success = Color(0xFF7CB342);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF64B5F6);

  // Surfaces
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF7F5F2);
  static const Color scaffoldBackground = Color(0xFFF7F5F2);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFFF5F3F0);

  // Text
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFFA0A0A0);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnAccent = Color(0xFF3D3227);

  // Keep old names for backward compatibility during migration
  static const Color textDark = textPrimary;
  static const Color textMedium = textSecondary;
  static const Color textLight = textTertiary;
  static const Color textOnSecondary = textOnAccent;
  static const Color secondary = accent;

  // UI Elements
  static const Color divider = Color(0xFFEDE9E4);
  static const Color shadow = Color(0x0A000000);
  static const Color shadowMedium = Color(0x14000000);
  static const Color overlay = Color(0x40000000);
  static const Color shimmer = Color(0xFFEDE9E4);

  // Bottom Nav
  static const Color navActive = primary;
  static const Color navInactive = Color(0xFFB0ADA8);
  static const Color navBackground = Color(0xFFFFFFFF);
}
