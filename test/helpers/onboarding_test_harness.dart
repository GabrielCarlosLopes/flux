import 'dart:io';

import 'package:flux/core/navigation/app_router.dart';
import 'package:flux/core/navigation/onboarding_redirect_notifier.dart';
import 'package:flux/core/services/database_service.dart';
import 'package:flux/features/onboarding/domain/entities/triage_challenge.dart';
import 'package:flux/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flux/features/onboarding/onboarding_scope.dart';
import 'package:isar/isar.dart';

/// Initializes Isar, redirect notifier, and [AppRouter] for widget/router tests.
Future<OnboardingRedirectNotifier> setupOnboardingHarness({
  bool markComplete = false,
  List<TriageChallenge> challenges = const [],
  OnboardingRepository? repository,
}) async {
  final tempDir = await Directory.systemTemp.createTemp('flux_test_');
  await DatabaseService.close();
  await DatabaseService.init(directory: tempDir.path);

  final repo = repository ?? OnboardingScope.repository();
  if (markComplete) {
    await OnboardingScope.completeUseCase(repo).call(challenges);
  }

  final notifier = OnboardingRedirectNotifier(
    OnboardingScope.isCompleteUseCase(repo),
  );
  await notifier.load();
  AppRouter.bind(notifier);
  return notifier;
}

Future<void> initIsarTestCore() async {
  await Isar.initializeIsarCore(download: true);
}

Future<void> tearDownOnboardingHarness() async {
  await DatabaseService.deleteFromDisk();
}
