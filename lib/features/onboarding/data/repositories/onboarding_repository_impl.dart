import '../../domain/entities/onboarding_profile.dart';
import '../../domain/entities/triage_challenge.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';
import '../models/onboarding_profile_model.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._localDataSource);

  final OnboardingLocalDataSource _localDataSource;

  @override
  Future<OnboardingProfile?> getProfile() async {
    final model = await _localDataSource.getProfile();
    if (model == null) {
      return null;
    }
    return _toEntity(model);
  }

  @override
  Future<bool> isOnboardingComplete() async {
    final model = await _localDataSource.getProfile();
    return model?.isComplete ?? false;
  }

  @override
  Future<void> completeOnboarding(List<TriageChallenge> challenges) async {
    final sortedIds = challenges.map((c) => c.id).toList()..sort();
    final existing = await _localDataSource.getProfile();
    final model = existing ?? OnboardingProfileModel()
      ..id = OnboardingProfileModel.onboardingProfileSingletonId;

    model
      ..isComplete = true
      ..completedAt = DateTime.now()
      ..challengeIds = sortedIds;

    await _localDataSource.upsertProfile(model);
  }

  OnboardingProfile _toEntity(OnboardingProfileModel model) {
    return OnboardingProfile(
      isComplete: model.isComplete,
      completedAt: model.completedAt,
      selectedChallenges: TriageChallenge.fromIds(model.challengeIds),
    );
  }
}
