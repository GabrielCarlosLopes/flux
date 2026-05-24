import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/triage_challenge.dart';

class TriageOptionCard extends StatelessWidget {
  const TriageOptionCard({
    super.key,
    required this.challenge,
    required this.selected,
    required this.onTap,
    required this.icon,
  });

  final TriageChallenge challenge;
  final bool selected;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final theme = AppTypography.textTheme(brightness);

    final backgroundColor = selected
        ? (brightness == Brightness.light
            ? AppColors.primaryContainer
            : AppColors.darkPrimaryContainer)
        : (brightness == Brightness.light
            ? AppColors.surfaceContainerLowest
            : AppColors.darkSurfaceContainer);

    final labelColor = selected
        ? (brightness == Brightness.light
            ? AppColors.onPrimaryContainer
            : AppColors.darkOnPrimaryContainer)
        : (brightness == Brightness.light
            ? AppColors.onSurface
            : AppColors.darkOnSurface);

    final iconBg = selected
        ? (brightness == Brightness.light
            ? AppColors.surfaceContainerLowest
            : AppColors.darkSurfaceContainerHigh)
        : (brightness == Brightness.light
            ? AppColors.surfaceContainer
            : AppColors.darkSurfaceContainer);

    final iconColor = selected
        ? (brightness == Brightness.light
            ? AppColors.primary
            : AppColors.darkPrimary)
        : (brightness == Brightness.light
            ? AppColors.onSurfaceVariant
            : AppColors.darkOnSurfaceVariant);

    return Semantics(
      button: true,
      selected: selected,
      label: challenge.label,
      child: Material(
        color: backgroundColor,
        elevation: selected ? 0 : 0,
        shadowColor: AppColors.primary.withValues(alpha: 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.gutter),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: selected
                  ? null
                  : [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.04),
                        blurRadius: 48,
                        offset: const Offset(0, 24),
                      ),
                    ],
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, size: 28, color: iconColor),
                ),
                const SizedBox(width: AppSpacing.gutter),
                Expanded(
                  child: Text(
                    challenge.label,
                    style: theme.bodyLarge?.copyWith(
                      color: labelColor,
                      fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: selected ? 1 : 0,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: selected ? 1 : 0.5,
                    child: Icon(
                      Icons.check_circle,
                      color: brightness == Brightness.light
                          ? AppColors.primary
                          : AppColors.darkPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
