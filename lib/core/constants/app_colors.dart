import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary - Deep Forest Green (trust, calm, strong contrast on light)
  static const Color primary = Color(0xFF2D6A4F);
  static const Color primaryLight = Color(0xFF40916C);
  static const Color primaryDark = Color(0xFF1B4332);
  static const Color primarySurface = Color(0xFFE9F5EF);

  // Accent - Warm Terracotta (warmth, elegance)
  static const Color accent = Color(0xFFD4956B);
  static const Color accentLight = Color(0xFFEBCDB5);
  static const Color accentDark = Color(0xFFB87A4F);

  // Gradients
  static const List<Color> gradientPrimary = [
    Color(0xFF2D6A4F),
    Color(0xFF40916C),
  ];
  static const List<Color> gradientAccent = [
    Color(0xFFD4956B),
    Color(0xFFEBCDB5),
  ];
  static const List<Color> gradientWarm = [
    Color(0xFFFAF9F7),
    Color(0xFFFFFFFF),
  ];

  // Semantic
  static const Color success = Color(0xFF52B788);
  static const Color error = Color(0xFFE07A6B);
  static const Color warning = Color(0xFFE5A54B);
  static const Color info = Color(0xFF5B9BD5);

  // Surfaces
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFAF9F7);
  static const Color scaffoldBackground = Color(0xFFFAF9F7);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFFF3F1EE);

  // Text
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF5C5C5C);
  static const Color textTertiary = Color(0xFF9A9A9A);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnAccent = Color(0xFF3D2E1F);

  // Backward compat aliases
  static const Color textDark = textPrimary;
  static const Color textMedium = textSecondary;
  static const Color textLight = textTertiary;
  static const Color textOnSecondary = textOnAccent;
  static const Color secondary = accent;

  // UI Elements
  static const Color divider = Color(0xFFE8E5E1);
  static const Color shadow = Color(0x0D000000);
  static const Color shadowMedium = Color(0x18000000);
  static const Color overlay = Color(0x40000000);
  static const Color shimmer = Color(0xFFE8E5E1);

  // Bottom Nav
  static const Color navActive = primary;
  static const Color navInactive = Color(0xFFADABA7);
  static const Color navBackground = Color(0xFFFFFFFF);
}
