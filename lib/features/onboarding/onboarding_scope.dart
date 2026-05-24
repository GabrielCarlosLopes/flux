import 'package:isar/isar.dart';

import '../../core/services/database_service.dart';
import 'data/datasources/onboarding_local_data_source.dart';
import 'data/repositories/onboarding_repository_impl.dart';
import 'domain/repositories/onboarding_repository.dart';
import 'domain/usecases/complete_onboarding_use_case.dart';
import 'domain/usecases/get_onboarding_profile_use_case.dart';
import 'domain/usecases/is_onboarding_complete_use_case.dart';

/// Manual composition root for the onboarding feature (no global DI).
abstract final class OnboardingScope {
  static OnboardingRepository repository([Isar? isar]) {
    final db = isar ?? DatabaseService.instance;
    return OnboardingRepositoryImpl(OnboardingLocalDataSource(db));
  }

  static IsOnboardingCompleteUseCase isCompleteUseCase([
    OnboardingRepository? repo,
  ]) =>
      IsOnboardingCompleteUseCase(repo ?? repository());

  static GetOnboardingProfileUseCase getProfileUseCase([
    OnboardingRepository? repo,
  ]) =>
      GetOnboardingProfileUseCase(repo ?? repository());

  static CompleteOnboardingUseCase completeUseCase([
    OnboardingRepository? repo,
  ]) =>
      CompleteOnboardingUseCase(repo ?? repository());
}
