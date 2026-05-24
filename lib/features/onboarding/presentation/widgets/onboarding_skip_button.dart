import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Discrete skip control — min 48×48 dp touch target.
class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final labelStyle = AppTypography.textTheme(brightness).labelMedium?.copyWith(
          color: brightness == Brightness.light
              ? AppColors.onSurfaceVariant
              : AppColors.darkOnSurfaceVariant,
        );

    return Semantics(
      button: true,
      label: 'Pular',
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Text('Pular', style: labelStyle),
      ),
    );
  }
}
