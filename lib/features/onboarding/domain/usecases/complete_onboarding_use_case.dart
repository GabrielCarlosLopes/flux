import '../entities/triage_challenge.dart';
import '../repositories/onboarding_repository.dart';

class CompleteOnboardingUseCase {
  CompleteOnboardingUseCase(this._repository);

  final OnboardingRepository _repository;

  // TODO(analytics): onboarding_completed

  Future<void> call(List<TriageChallenge> challenges) =>
      _repository.completeOnboarding(challenges);
}
