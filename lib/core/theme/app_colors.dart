import 'package:flutter/material.dart';

/// Serene Focus palette from DESIGN.md (hex literals).
abstract final class AppColors {
  // Light — surface & background
  static const Color surface = Color(0xFFF7FAFB);
  static const Color surfaceDim = Color(0xFFD7DADB);
  static const Color surfaceBright = Color(0xFFF7FAFB);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF1F4F5);
  static const Color surfaceContainer = Color(0xFFEBEEEF);
  static const Color surfaceContainerHigh = Color(0xFFE6E9EA);
  static const Color surfaceContainerHighest = Color(0xFFE0E3E4);
  static const Color onSurface = Color(0xFF181C1D);
  static const Color onSurfaceVariant = Color(0xFF424842);
  static const Color inverseSurface = Color(0xFF2D3132);
  static const Color inverseOnSurface = Color(0xFFEEF1F2);
  static const Color outline = Color(0xFF737972);
  static const Color outlineVariant = Color(0xFFC2C8C0);
  static const Color surfaceTint = Color(0xFF4A654E);
  static const Color background = Color(0xFFF7FAFB);
  static const Color onBackground = Color(0xFF181C1D);
  static const Color surfaceVariant = Color(0xFFE0E3E4);

  // Primary (Sage Green)
  static const Color primary = Color(0xFF4A654E);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF8BA88E);
  static const Color onPrimaryContainer = Color(0xFF233D29);
  static const Color inversePrimary = Color(0xFFB0CEB2);

  // Secondary (Soft Blue)
  static const Color secondary = Color(0xFF466274);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFC9E6FD);
  static const Color onSecondaryContainer = Color(0xFF4C687B);

  // Tertiary (Warm Cream tones)
  static const Color tertiary = Color(0xFF5F5E5B);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFA3A19C);
  static const Color onTertiaryContainer = Color(0xFF383835);

  // Error
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Dark — charcoal base, accents ~15% desaturated (DESIGN.md dark mode note)
  static const Color darkBackground = Color(0xFF2D3132);
  static const Color darkSurface = Color(0xFF2D3132);
  static const Color darkOnSurface = Color(0xFFEEF1F2);
  static const Color darkOnSurfaceVariant = Color(0xFFC2C8C0);
  static const Color darkSurfaceContainerLow = Color(0xFF363A3B);
  static const Color darkSurfaceContainer = Color(0xFF3D4142);
  static const Color darkSurfaceContainerHigh = Color(0xFF45494A);
  static const Color darkOutline = Color(0xFF8A9088);
  static const Color darkOutlineVariant = Color(0xFF5A6058);
  static const Color darkPrimary = Color(0xFF5F7A63);
  static const Color darkOnPrimary = Color(0xFF07200F);
  static const Color darkPrimaryContainer = Color(0xFF334D38);
  static const Color darkOnPrimaryContainer = Color(0xFFCCEACE);
  static const Color darkSecondary = Color(0xFF5A7589);
  static const Color darkOnSecondary = Color(0xFF001E2D);
  static const Color darkSecondaryContainer = Color(0xFF2E4A5C);
  static const Color darkOnSecondaryContainer = Color(0xFFC9E6FD);
  static const Color darkTertiary = Color(0xFF78766F);
  static const Color darkOnTertiary = Color(0xFF1C1C19);
  static const Color darkError = Color(0xFFFFB4AB);
  static const Color darkOnError = Color(0xFF690005);
  static const Color darkErrorContainer = Color(0xFF93000A);
  static const Color darkOnErrorContainer = Color(0xFFFFDAD6);
}
