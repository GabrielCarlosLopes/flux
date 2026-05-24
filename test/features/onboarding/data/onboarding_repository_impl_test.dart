import 'package:flutter_test/flutter_test.dart';
import 'package:flux/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:flux/features/onboarding/data/models/onboarding_profile_model.dart';
import 'package:flux/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:flux/features/onboarding/domain/entities/triage_challenge.dart';
import 'package:flux/core/services/database_service.dart';

import '../../../helpers/onboarding_test_harness.dart';

void main() {
  setUpAll(initIsarTestCore);

  tearDown(tearDownOnboardingHarness);

  test('get and upsert singleton id=1', () async {
    await setupOnboardingHarness();
    final repo = OnboardingRepositoryImpl(
      OnboardingLocalDataSource(DatabaseService.instance),
    );

    expect(await repo.isOnboardingComplete(), isFalse);

    await repo.completeOnboarding([
      TriageChallenge.procrastination,
      TriageChallenge.focus,
    ]);

    final profile = await repo.getProfile();
    expect(profile, isNotNull);
    expect(profile!.isComplete, isTrue);
    expect(profile.selectedChallenges, hasLength(2));

    final raw = await DatabaseService.instance.onboardingProfileModels.get(
      OnboardingProfileModel.onboardingProfileSingletonId,
    );
    expect(raw?.id, OnboardingProfileModel.onboardingProfileSingletonId);
    expect(raw?.challengeIds, ['focus', 'procrastination']);
  });

  test('round-trip all five challenge ids', () async {
    await setupOnboardingHarness();
    final repo = OnboardingRepositoryImpl(
      OnboardingLocalDataSource(DatabaseService.instance),
    );

    await repo.completeOnboarding(TriageChallenge.values);

    final profile = await repo.getProfile();
    expect(
      profile!.selectedChallenges.map((c) => c.id).toList()..sort(),
      TriageChallenge.values.map((c) => c.id).toList()..sort(),
    );
  });
}
