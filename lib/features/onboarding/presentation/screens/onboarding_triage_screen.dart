import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/triage_challenge.dart';
import '../viewmodels/onboarding_triage_view_model.dart';
import '../widgets/onboarding_progress_ring.dart';
import '../widgets/onboarding_skip_button.dart';
import '../widgets/triage_option_card.dart';

class OnboardingTriageScreen extends StatefulWidget {
  const OnboardingTriageScreen({
    super.key,
    required this.viewModel,
    required this.onBack,
  });

  final OnboardingTriageViewModel viewModel;
  final VoidCallback onBack;

  static const String headline = 'O que mais te atrapalha hoje?';

  @override
  State<OnboardingTriageScreen> createState() => _OnboardingTriageScreenState();
}

class _OnboardingTriageScreenState extends State<OnboardingTriageScreen> {
  static const Map<TriageChallenge, IconData> _icons = {
    TriageChallenge.procrastination: Icons.hourglass_empty,
    TriageChallenge.forgetting: Icons.event_busy,
    TriageChallenge.focus: Icons.center_focus_strong,
    TriageChallenge.anxiety: Icons.blur_on,
    TriageChallenge.starting: Icons.rocket_launch,
  };

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final textTheme = AppTypography.textTheme(brightness);
    final backgroundColor = brightness == Brightness.light
        ? AppColors.background
        : AppColors.darkBackground;
    final wide = MediaQuery.sizeOf(context).width >= 600;
    final vm = widget.viewModel;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.containerMarginMobile,
                vertical: AppSpacing.gutter,
              ),
              child: Row(
                children: [
                  Semantics(
                    button: true,
                    label: 'Voltar',
                    child: Material(
                      color: brightness == Brightness.light
                          ? AppColors.surfaceContainerLowest
                          : AppColors.darkSurfaceContainer,
                      shape: const CircleBorder(),
                      elevation: 0,
                      shadowColor:
                          AppColors.primary.withValues(alpha: 0.04),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: widget.onBack,
                        child: const SizedBox(
                          width: 48,
                          height: 48,
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const OnboardingProgressRing(),
                  const Spacer(),
                  OnboardingSkipButton(onPressed: () => vm.onSkip()),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.containerMarginMobile,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.lg),
                      Semantics(
                        header: true,
                        child: Text(
                          OnboardingTriageScreen.headline,
                          textAlign: TextAlign.center,
                          style: (wide
                                  ? textTheme.displayLarge
                                  : textTheme.headlineMedium)
                              ?.copyWith(
                            color: brightness == Brightness.light
                                ? AppColors.onBackground
                                : AppColors.darkOnSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sectionGap),
                      ListenableBuilder(
                        listenable: vm,
                        builder: (context, _) {
                          return Column(
                            children: [
                              for (final challenge in TriageChallenge.values)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppSpacing.md,
                                  ),
                                  child: TriageOptionCard(
                                    key: ValueKey(challenge.id),
                                    challenge: challenge,
                                    selected: vm.isSelected(challenge),
                                    icon: _icons[challenge]!,
                                    onTap: () => vm.toggle(challenge),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.sectionGap),
                      ListenableBuilder(
                        listenable: vm,
                        builder: (context, _) {
                          final enabled = vm.canContinue;
                          return Semantics(
                            button: true,
                            label: 'Continuar',
                            enabled: enabled,
                            child: SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: FilledButton(
                                onPressed:
                                    enabled ? () => vm.onContinue() : null,
                                style: FilledButton.styleFrom(
                                  backgroundColor: enabled
                                      ? (brightness == Brightness.light
                                          ? AppColors.primary
                                          : AppColors.darkPrimary)
                                      : (brightness == Brightness.light
                                          ? AppColors.surfaceContainerHighest
                                          : AppColors.darkSurfaceContainerHigh),
                                  foregroundColor: enabled
                                      ? (brightness == Brightness.light
                                          ? AppColors.onPrimary
                                          : AppColors.darkOnPrimary)
                                      : (brightness == Brightness.light
                                          ? AppColors.onSurfaceVariant
                                          : AppColors.darkOnSurfaceVariant),
                                  disabledBackgroundColor: brightness ==
                                          Brightness.light
                                      ? AppColors.surfaceContainerHighest
                                      : AppColors.darkSurfaceContainerHigh,
                                  disabledForegroundColor: brightness ==
                                          Brightness.light
                                      ? AppColors.onSurfaceVariant
                                      : AppColors.darkOnSurfaceVariant,
                                  shape: const StadiumBorder(),
                                ),
                                child: Text(
                                  'Continuar',
                                  style: textTheme.labelMedium?.copyWith(
                                    color: enabled
                                        ? (brightness == Brightness.light
                                            ? AppColors.onPrimary
                                            : AppColors.darkOnPrimary)
                                        : (brightness == Brightness.light
                                            ? AppColors.onSurfaceVariant
                                            : AppColors.darkOnSurfaceVariant),
                                    letterSpacing: 0.05 * 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
