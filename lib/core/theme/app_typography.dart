import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Serene Focus typography mapped to Flutter [TextTheme].
abstract final class AppTypography {
  static TextTheme textTheme(Brightness brightness) {
    final onSurface = brightness == Brightness.light
        ? AppColors.onSurface
        : AppColors.darkOnSurface;
    final onSurfaceVariant = brightness == Brightness.light
        ? AppColors.onSurfaceVariant
        : AppColors.darkOnSurfaceVariant;

    final base = TextTheme(
      displayLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        height: 52 / 40,
        letterSpacing: -0.02 * 40,
        color: onSurface,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 40 / 32,
        letterSpacing: -0.01 * 32,
        color: onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 36 / 28,
        color: onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 32 / 20,
        color: onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 32 / 20,
        color: onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 26 / 16,
        color: onSurface,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 20 / 14,
        letterSpacing: 0.05 * 14,
        color: onSurfaceVariant,
      ),
    );

    return GoogleFonts.hankenGroteskTextTheme(base);
  }
}
