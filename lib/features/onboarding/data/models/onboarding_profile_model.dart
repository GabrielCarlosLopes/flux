import 'package:isar/isar.dart';

part 'onboarding_profile_model.g.dart';

/// Singleton onboarding document (always [onboardingProfileSingletonId]).
@collection
class OnboardingProfileModel {
  static const int onboardingProfileSingletonId = 1;

  Id id = onboardingProfileSingletonId;

  bool isComplete = false;

  DateTime? completedAt;

  List<String> challengeIds = [];
}
