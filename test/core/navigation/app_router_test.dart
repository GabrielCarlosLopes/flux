import 'package:flutter_test/flutter_test.dart';
import 'package:flux/core/navigation/app_router.dart';
import 'package:flux/core/navigation/onboarding_redirect_notifier.dart';
import 'package:flux/core/navigation/route_paths.dart';
import 'package:flux/features/onboarding/domain/usecases/is_onboarding_complete_use_case.dart';

import '../../features/onboarding/fakes/fake_onboarding_repository.dart';
import '../../helpers/onboarding_test_harness.dart';

void main() {
  setUpAll(initIsarTestCore);

  tearDown(tearDownOnboardingHarness);

  test('GoRouter initialLocation is /tasks', () async {
    await setupOnboardingHarness(markComplete: true);
    final router = AppRouter.router;
    expect(router.routeInformationProvider.value.uri.path, RoutePaths.tasks);
  });

  test('redirect sends incomplete users to onboarding', () async {
    final notifier = OnboardingRedirectNotifier(
      IsOnboardingCompleteUseCase(FakeOnboardingRepository()),
    );
    await notifier.load();

    expect(
      AppRouter.redirectForPath(RoutePaths.tasks, notifier),
      RoutePaths.onboarding,
    );
    expect(
      AppRouter.redirectForPath(RoutePaths.onboardingTriage, notifier),
      isNull,
    );
  });

  test('redirect blocks onboarding when complete', () async {
    final notifier = OnboardingRedirectNotifier(
      IsOnboardingCompleteUseCase(FakeOnboardingRepository(isComplete: true)),
    );
    await notifier.load();

    expect(
      AppRouter.redirectForPath(RoutePaths.onboarding, notifier),
      RoutePaths.tasks,
    );
    expect(
      AppRouter.redirectForPath(RoutePaths.onboardingTriage, notifier),
      RoutePaths.tasks,
    );
    expect(AppRouter.redirectForPath('/invalid-route', notifier), isNull);
  });

  test('redirect returns null while loading', () {
    final notifier = OnboardingRedirectNotifier(
      IsOnboardingCompleteUseCase(FakeOnboardingRepository()),
    );
    expect(AppRouter.redirectForPath(RoutePaths.tasks, notifier), isNull);
  });

  test('refreshListenable reflects repository after complete', () async {
    final fake = FakeOnboardingRepository();
    final notifier = OnboardingRedirectNotifier(
      IsOnboardingCompleteUseCase(fake),
    );
    await notifier.load();
    expect(notifier.isComplete, isFalse);

    await fake.completeOnboarding([]);
    await notifier.refresh();
    expect(notifier.isComplete, isTrue);
  });

  test('initialLocation stays /tasks when onboarding complete', () async {
    await setupOnboardingHarness(markComplete: true);
    expect(AppRouter.router.routeInformationProvider.value.uri.path,
        RoutePaths.tasks);
  });

  test('harness incomplete leaves redirect target as onboarding', () async {
    await setupOnboardingHarness(markComplete: false);
    final notifier = OnboardingRedirectNotifier(
      IsOnboardingCompleteUseCase(FakeOnboardingRepository()),
    );
    await notifier.load();
    expect(
      AppRouter.redirectForPath(RoutePaths.tasks, notifier),
      RoutePaths.onboarding,
    );
  });
}
