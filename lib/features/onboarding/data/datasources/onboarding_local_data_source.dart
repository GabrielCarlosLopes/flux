import 'package:isar/isar.dart';

import '../models/onboarding_profile_model.dart';

class OnboardingLocalDataSource {
  OnboardingLocalDataSource(this._isar);

  final Isar _isar;

  Future<OnboardingProfileModel?> getProfile() {
    return _isar.onboardingProfileModels.get(
      OnboardingProfileModel.onboardingProfileSingletonId,
    );
  }

  Future<void> upsertProfile(OnboardingProfileModel profile) async {
    await _isar.writeTxn(() async {
      await _isar.onboardingProfileModels.put(profile);
    });
  }
}
