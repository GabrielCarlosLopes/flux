import 'package:flutter/foundation.dart';

import '../../features/onboarding/domain/usecases/is_onboarding_complete_use_case.dart';

/// Caches onboarding completion for [GoRouter] redirect + [refreshListenable].
class OnboardingRedirectNotifier extends ChangeNotifier {
  OnboardingRedirectNotifier(this._isOnboardingComplete);

  final IsOnboardingCompleteUseCase _isOnboardingComplete;

  /// `null` while loading; `false` on error (fail-safe).
  bool? isComplete;

  bool get isLoading => isComplete == null;

  Future<void> load() async {
    try {
      isComplete = await _isOnboardingComplete();
    } catch (_) {
      isComplete = false;
    }
    notifyListeners();
  }

  Future<void> refresh() => load();
}
