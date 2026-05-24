import 'package:flutter/foundation.dart';

import '../../domain/entities/triage_challenge.dart';
import '../../domain/usecases/complete_onboarding_use_case.dart';

class OnboardingTriageViewModel extends ChangeNotifier {
  OnboardingTriageViewModel({
    required CompleteOnboardingUseCase completeOnboarding,
    required Future<void> Function() onAfterComplete,
  })  : _completeOnboarding = completeOnboarding,
        _onAfterComplete = onAfterComplete;

  final CompleteOnboardingUseCase _completeOnboarding;
  final Future<void> Function() _onAfterComplete;

  final Set<TriageChallenge> _selected = {};

  Set<TriageChallenge> get selected => Set.unmodifiable(_selected);

  bool get canContinue => _selected.isNotEmpty;

  bool isSelected(TriageChallenge challenge) => _selected.contains(challenge);

  void toggle(TriageChallenge challenge) {
    if (_selected.contains(challenge)) {
      _selected.remove(challenge);
    } else {
      _selected.add(challenge);
    }
    notifyListeners();
  }

  Future<void> onContinue() async {
    if (!canContinue) {
      return;
    }
    await _completeOnboarding(_selected.toList(growable: false));
    await _onAfterComplete();
  }

  Future<void> onSkip() async {
    final challenges = _selected.toList(growable: false);
    await _completeOnboarding(challenges);
    await _onAfterComplete();
  }

}
