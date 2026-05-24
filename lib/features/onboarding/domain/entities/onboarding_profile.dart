import 'triage_challenge.dart';

/// Domain model for persisted onboarding state.
class OnboardingProfile {
  const OnboardingProfile({
    required this.isComplete,
    this.completedAt,
    this.selectedChallenges = const [],
  });

  final bool isComplete;
  final DateTime? completedAt;
  final List<TriageChallenge> selectedChallenges;
}
