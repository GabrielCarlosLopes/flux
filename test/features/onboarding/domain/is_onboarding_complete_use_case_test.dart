import 'package:flutter_test/flutter_test.dart';
import 'package:flux/features/onboarding/onboarding_scope.dart';

import '../../../helpers/onboarding_test_harness.dart';

void main() {
  setUpAll(initIsarTestCore);

  tearDown(tearDownOnboardingHarness);

  test('returns false when no profile exists', () async {
    await setupOnboardingHarness();
    final useCase = OnboardingScope.isCompleteUseCase();
    expect(await useCase(), isFalse);
  });

  test('returns true after onboarding is completed', () async {
    await setupOnboardingHarness(markComplete: true);
    final useCase = OnboardingScope.isCompleteUseCase();
    expect(await useCase(), isTrue);
  });
}
