import 'package:flux/features/onboarding/domain/entities/onboarding_profile.dart';
import 'package:flux/features/onboarding/domain/entities/triage_challenge.dart';
import 'package:flux/features/onboarding/domain/repositories/onboarding_repository.dart';

class FakeOnboardingRepository implements OnboardingRepository {
  FakeOnboardingRepository({this.isComplete = false});

  bool isComplete;
  List<TriageChallenge> lastChallenges = const [];
  bool throwOnComplete = false;

  @override
  Future<void> completeOnboarding(List<TriageChallenge> challenges) async {
    if (throwOnComplete) {
      throw StateError('simulated failure');
    }
    lastChallenges = List.unmodifiable(challenges);
    isComplete = true;
  }

  @override
  Future<OnboardingProfile?> getProfile() async {
    if (!isComplete) {
      return null;
    }
    return OnboardingProfile(
      isComplete: true,
      completedAt: DateTime(2026, 5, 24),
      selectedChallenges: lastChallenges,
    );
  }

  @override
  Future<bool> isOnboardingComplete() async => isComplete;
}
