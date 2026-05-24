import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../viewmodels/onboarding_welcome_view_model.dart';
import '../widgets/onboarding_blur_orbs_background.dart';
import '../widgets/onboarding_skip_button.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({
    super.key,
    required this.viewModel,
  });

  final OnboardingWelcomeViewModel viewModel;

  static const String headline = 'Vamos desacelerar a sua mente?';
  static const String subtitle =
      'Um espaço seguro para você realizar o que importa, um passo de cada vez.';

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textTheme = AppTypography.textTheme(brightness);
    final backgroundColor = brightness == Brightness.light
        ? AppColors.background
        : AppColors.darkBackground;
    final wide = MediaQuery.sizeOf(context).width >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          const OnboardingBlurOrbsBackground(),
          SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: OnboardingSkipButton(
                    onPressed: () => viewModel.onSkip(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.containerMarginMobile,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 672),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Semantics(
                                  header: true,
                                  child: Text(
                                    headline,
                                    textAlign: TextAlign.center,
                                    style: (wide
                                            ? textTheme.displayLarge
                                            : textTheme.displayLarge)
                                        ?.copyWith(
                                      color: brightness == Brightness.light
                                          ? AppColors.onSurface
                                          : AppColors.darkOnSurface,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                Text(
                                  subtitle,
                                  textAlign: TextAlign.center,
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: brightness == Brightness.light
                                        ? AppColors.onSurfaceVariant
                                        : AppColors.darkOnSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sectionGap),
                      Semantics(
                        button: true,
                        label: 'Começar',
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: FilledButton(
                            onPressed: viewModel.onStart,
                            style: FilledButton.styleFrom(
                              backgroundColor: brightness == Brightness.light
                                  ? AppColors.primary
                                  : AppColors.darkPrimary,
                              foregroundColor: brightness == Brightness.light
                                  ? AppColors.onPrimary
                                  : AppColors.darkOnPrimary,
                              shape: const StadiumBorder(),
                              elevation: 0,
                              shadowColor:
                                  AppColors.primary.withValues(alpha: 0.12),
                            ),
                            child: Text(
                              'Começar',
                              style: textTheme.labelMedium?.copyWith(
                                color: brightness == Brightness.light
                                    ? AppColors.onPrimary
                                    : AppColors.darkOnPrimary,
                                letterSpacing: 0.05 * 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppSpacing.containerMarginMobile +
                            MediaQuery.paddingOf(context).bottom,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
