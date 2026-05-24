import 'package:flutter/material.dart';

/// Border radius tokens from DESIGN.md (1rem = 16px).
abstract final class AppRadius {
  static const double sm = 8;
  static const double defaultRadius = 16;
  static const double md = 24;
  static const double lg = 32;
  static const double xl = 48;
  static const double full = 9999;

  static const BorderRadius smBorder = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius defaultBorder =
      BorderRadius.all(Radius.circular(defaultRadius));
  static const BorderRadius mdBorder = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgBorder = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlBorder = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius fullBorder =
      BorderRadius.all(Radius.circular(full));
}
