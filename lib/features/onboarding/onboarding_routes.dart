import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/navigation/onboarding_redirect_notifier.dart';
import '../../core/navigation/route_paths.dart';
import 'domain/repositories/onboarding_repository.dart';
import 'onboarding_scope.dart';
import 'presentation/screens/onboarding_triage_screen.dart';
import 'presentation/screens/onboarding_welcome_screen.dart';
import 'presentation/viewmodels/onboarding_triage_view_model.dart';
import 'presentation/viewmodels/onboarding_welcome_view_model.dart';

abstract final class OnboardingRoutes {
  static GoRoute route({
    required OnboardingRedirectNotifier redirectNotifier,
    OnboardingRepository? repository,
  }) {
    final repo = repository ?? OnboardingScope.repository();

    Future<void> afterComplete(BuildContext context) async {
      await redirectNotifier.refresh();
      if (context.mounted) {
        context.go(RoutePaths.tasks);
      }
    }

    return GoRoute(
      path: RoutePaths.onboarding,
      builder: (context, state) {
        final viewModel = OnboardingWelcomeViewModel(
          completeOnboarding: OnboardingScope.completeUseCase(repo),
          onNavigateToTriage: () => context.go(RoutePaths.onboardingTriage),
          onAfterComplete: () => afterComplete(context),
        );
        return OnboardingWelcomeScreen(viewModel: viewModel);
      },
      routes: [
        GoRoute(
          path: 'triage',
          builder: (context, state) {
            final viewModel = OnboardingTriageViewModel(
              completeOnboarding: OnboardingScope.completeUseCase(repo),
              onAfterComplete: () => afterComplete(context),
            );
            return OnboardingTriageScreen(
              viewModel: viewModel,
              onBack: () => context.pop(),
            );
          },
        ),
      ],
    );
  }
}
