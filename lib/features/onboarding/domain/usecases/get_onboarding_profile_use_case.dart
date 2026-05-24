import '../entities/onboarding_profile.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingProfileUseCase {
  GetOnboardingProfileUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<OnboardingProfile?> call() => _repository.getProfile();
}
