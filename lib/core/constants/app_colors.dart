import 'package:flutter/material.dart';

/// Brand palette for SIGRA. Semantic colors (primary, accent, success, error,
/// warning, info, gradients) are constant across themes. Surface and text
/// colors switch between a warm off-white light palette and a deep forest
/// dark palette tuned to harmonize with the green primary.
///
/// Toggle the active palette with [setDarkMode]. The static getters are read
/// during widget build, so when the app rebuilds (e.g. after a theme toggle),
/// the dynamic colors propagate everywhere automatically.
class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // Theme switch
  // ---------------------------------------------------------------------------
  static bool _isDark = false;

  static bool get isDark => _isDark;

  static void setDarkMode(bool value) {
    _isDark = value;
  }

  // ---------------------------------------------------------------------------
  // Static (semantic) colors — same in light and dark
  // ---------------------------------------------------------------------------

  // Primary - Deep Forest Green
  static const Color primary = Color(0xFF2D6A4F);
  static const Color primaryLight = Color(0xFF40916C);
  static const Color primaryDark = Color(0xFF1B4332);

  // Accent - Warm Terracotta
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

  // Text on tinted backgrounds
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnAccent = Color(0xFF3D2E1F);
  static const Color textOnSecondary = textOnAccent;
  static const Color secondary = accent;

  // Always-dark overlays
  static const Color overlay = Color(0x40000000);

  // ---------------------------------------------------------------------------
  // Light palette (warm off-white)
  // ---------------------------------------------------------------------------
  static const Color _lightScaffold = Color(0xFFFAF9F7);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightCard = Color(0xFFFFFFFF);
  static const Color _lightInput = Color(0xFFF3F1EE);
  static const Color _lightPrimarySurface = Color(0xFFE9F5EF);
  static const Color _lightTextPrimary = Color(0xFF1A1A1A);
  static const Color _lightTextSecondary = Color(0xFF5C5C5C);
  static const Color _lightTextTertiary = Color(0xFF9A9A9A);
  static const Color _lightDivider = Color(0xFFE8E5E1);
  static const Color _lightShadow = Color(0x0D000000);
  static const Color _lightShadowMedium = Color(0x18000000);
  static const Color _lightShimmer = Color(0xFFE8E5E1);
  static const Color _lightNavBackground = Color(0xFFFFFFFF);
  static const Color _lightNavInactive = Color(0xFFADABA7);

  // ---------------------------------------------------------------------------
  // Dark palette (deep forest, tuned to harmonize with the green primary)
  // ---------------------------------------------------------------------------
  static const Color _darkScaffold = Color(0xFF0F1814);
  static const Color _darkSurface = Color(0xFF1A2520);
  static const Color _darkCard = Color(0xFF1F2D27);
  static const Color _darkInput = Color(0xFF243530);
  static const Color _darkPrimarySurface = Color(0xFF244B3B);
  static const Color _darkTextPrimary = Color(0xFFE8EDE9);
  static const Color _darkTextSecondary = Color(0xFFB5C0BA);
  static const Color _darkTextTertiary = Color(0xFF7B8782);
  static const Color _darkDivider = Color(0xFF2D3F37);
  static const Color _darkShadow = Color(0x40000000);
  static const Color _darkShadowMedium = Color(0x60000000);
  static const Color _darkShimmer = Color(0xFF2D3F37);
  static const Color _darkNavBackground = Color(0xFF131C18);
  static const Color _darkNavInactive = Color(0xFF6B7873);

  // ---------------------------------------------------------------------------
  // Dynamic getters (resolve based on active mode)
  // ---------------------------------------------------------------------------

  // Surfaces
  static Color get scaffoldBackground =>
      _isDark ? _darkScaffold : _lightScaffold;
  static Color get background => _isDark ? _darkScaffold : _lightScaffold;
  static Color get surface => _isDark ? _darkSurface : _lightSurface;
  static Color get cardBackground => _isDark ? _darkCard : _lightCard;
  static Color get inputBackground => _isDark ? _darkInput : _lightInput;
  static Color get primarySurface =>
      _isDark ? _darkPrimarySurface : _lightPrimarySurface;

  // Text
  static Color get textPrimary =>
      _isDark ? _darkTextPrimary : _lightTextPrimary;
  static Color get textSecondary =>
      _isDark ? _darkTextSecondary : _lightTextSecondary;
  static Color get textTertiary =>
      _isDark ? _darkTextTertiary : _lightTextTertiary;

  // Backward-compat aliases
  static Color get textDark => textPrimary;
  static Color get textMedium => textSecondary;
  static Color get textLight => textTertiary;

  // UI
  static Color get divider => _isDark ? _darkDivider : _lightDivider;
  static Color get shadow => _isDark ? _darkShadow : _lightShadow;
  static Color get shadowMedium =>
      _isDark ? _darkShadowMedium : _lightShadowMedium;
  static Color get shimmer => _isDark ? _darkShimmer : _lightShimmer;

  // Bottom nav
  static Color get navActive => primary;
  static Color get navInactive =>
      _isDark ? _darkNavInactive : _lightNavInactive;
  static Color get navBackground =>
      _isDark ? _darkNavBackground : _lightNavBackground;
}
