import '../../domain/entities/triage_challenge.dart';
import '../../domain/usecases/complete_onboarding_use_case.dart';

/// Welcome step: navigation callbacks are injected by the screen (no [BuildContext]).
class OnboardingWelcomeViewModel {
  OnboardingWelcomeViewModel({
    required CompleteOnboardingUseCase completeOnboarding,
    required void Function() onNavigateToTriage,
    required Future<void> Function() onAfterComplete,
  })  : _completeOnboarding = completeOnboarding,
        _onNavigateToTriage = onNavigateToTriage,
        _onAfterComplete = onAfterComplete;

  final CompleteOnboardingUseCase _completeOnboarding;
  final void Function() _onNavigateToTriage;
  final Future<void> Function() _onAfterComplete;

  void onStart() => _onNavigateToTriage();

  Future<void> onSkip() async {
    await _completeOnboarding(const <TriageChallenge>[]);
    await _onAfterComplete();
  }
}
