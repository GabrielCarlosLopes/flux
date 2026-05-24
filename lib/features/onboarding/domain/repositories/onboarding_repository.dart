import '../entities/onboarding_profile.dart';
import '../entities/triage_challenge.dart';

abstract interface class OnboardingRepository {
  Future<OnboardingProfile?> getProfile();

  Future<bool> isOnboardingComplete();

  Future<void> completeOnboarding(List<TriageChallenge> challenges);
}
