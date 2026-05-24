import 'package:flutter_test/flutter_test.dart';
import 'package:flux/features/onboarding/domain/entities/triage_challenge.dart';
import 'package:flux/features/onboarding/onboarding_scope.dart';

import '../../../helpers/onboarding_test_harness.dart';

void main() {
  setUpAll(initIsarTestCore);

  tearDown(tearDownOnboardingHarness);

  test('skip welcome with empty DB marks complete with no challenges', () async {
    await setupOnboardingHarness();
    await OnboardingScope.completeUseCase().call(const <TriageChallenge>[]);

    expect(await OnboardingScope.isCompleteUseCase()(), isTrue);
    final profile = await OnboardingScope.getProfileUseCase()();
    expect(profile?.selectedChallenges, isEmpty);
  });
}
