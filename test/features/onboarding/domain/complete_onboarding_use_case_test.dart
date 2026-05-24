import 'package:flutter_test/flutter_test.dart';
import 'package:flux/features/onboarding/domain/entities/triage_challenge.dart';
import 'package:flux/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:flux/features/onboarding/domain/usecases/get_onboarding_profile_use_case.dart';
import 'package:flux/features/onboarding/onboarding_scope.dart';

import '../../../helpers/onboarding_test_harness.dart';

void main() {
  setUpAll(initIsarTestCore);

  tearDown(tearDownOnboardingHarness);

  test('persists sorted challenge ids and completedAt', () async {
    await setupOnboardingHarness();
    final complete = OnboardingScope.completeUseCase();
    final getProfile = OnboardingScope.getProfileUseCase();

    await complete([
      TriageChallenge.starting,
      TriageChallenge.focus,
      TriageChallenge.anxiety,
    ]);

    final profile = await getProfile();
    expect(profile, isNotNull);
    expect(profile!.isComplete, isTrue);
    expect(profile.completedAt, isNotNull);
    expect(
      profile.selectedChallenges.map((c) => c.id).toList(),
      ['anxiety', 'focus', 'starting'],
    );
  });

  test('second call remains complete (idempotent)', () async {
    await setupOnboardingHarness();
    final complete = CompleteOnboardingUseCase(OnboardingScope.repository());
    final getProfile = GetOnboardingProfileUseCase(OnboardingScope.repository());

    await complete([TriageChallenge.procrastination]);
    final first = await getProfile();
    await complete([TriageChallenge.forgetting]);
    final second = await getProfile();

    expect(first!.isComplete, isTrue);
    expect(second!.isComplete, isTrue);
    expect(second.selectedChallenges, [TriageChallenge.forgetting]);
  });
}
