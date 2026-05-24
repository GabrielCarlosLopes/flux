import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/focus/presentation/screens/focus_stub_screen.dart';
import '../../features/insights/presentation/screens/insights_stub_screen.dart';
import '../../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../../features/onboarding/onboarding_routes.dart';
import '../../features/onboarding/onboarding_scope.dart';
import '../../features/premium/presentation/screens/premium_stub_screen.dart';
import '../../features/routines/presentation/screens/routines_stub_screen.dart';
import '../../features/settings/presentation/screens/settings_stub_screen.dart';
import '../../features/tasks/presentation/screens/tasks_stub_screen.dart';
import 'onboarding_redirect_notifier.dart';
import 'route_paths.dart';

/// Central [GoRouter] configuration.
abstract final class AppRouter {
  static OnboardingRedirectNotifier? _boundNotifier;
  static GoRouter? _router;

  /// Binds production [OnboardingRedirectNotifier] before accessing [router].
  static void bind(OnboardingRedirectNotifier notifier) {
    _boundNotifier = notifier;
    _router = null;
  }

  static GoRouter get router {
    return _router ??= create(redirectNotifier: _boundNotifier);
  }

  /// Fresh instance for tests; production uses [router] after [bind].
  @visibleForTesting
  static GoRouter create({
    OnboardingRedirectNotifier? redirectNotifier,
    OnboardingRepository? onboardingRepository,
  }) {
    final repo = onboardingRepository ?? OnboardingScope.repository();
    final notifier = redirectNotifier ??
        OnboardingRedirectNotifier(OnboardingScope.isCompleteUseCase(repo));

    return GoRouter(
      initialLocation: RoutePaths.tasks,
      debugLogDiagnostics: kDebugMode,
      refreshListenable: notifier,
      redirect: (context, state) => _redirect(state, notifier),
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Rota não encontrada')),
        body: Center(
          child: Text(
            'Caminho inválido: ${state.uri.path}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      routes: [
        OnboardingRoutes.route(
          redirectNotifier: notifier,
          repository: repo,
        ),
        GoRoute(
          path: RoutePaths.tasks,
          builder: (context, state) => const TasksStubScreen(),
        ),
        GoRoute(
          path: RoutePaths.focus,
          builder: (context, state) => const FocusStubScreen(),
        ),
        GoRoute(
          path: RoutePaths.routines,
          builder: (context, state) => const RoutinesStubScreen(),
        ),
        GoRoute(
          path: RoutePaths.insights,
          builder: (context, state) => const InsightsStubScreen(),
        ),
        GoRoute(
          path: RoutePaths.settings,
          builder: (context, state) => const SettingsStubScreen(),
        ),
        GoRoute(
          path: RoutePaths.premium,
          builder: (context, state) => const PremiumStubScreen(),
        ),
      ],
    );
  }

  @visibleForTesting
  static String? redirectForPath(
    String path,
    OnboardingRedirectNotifier notifier,
  ) =>
      _redirectForPath(path, notifier);

  static String? _redirect(GoRouterState state, OnboardingRedirectNotifier notifier) {
    return _redirectForPath(state.uri.path, notifier);
  }

  static String? _redirectForPath(
    String path,
    OnboardingRedirectNotifier notifier,
  ) {
    final complete = notifier.isComplete;
    if (complete == null) {
      return null;
    }

    final onOnboarding = path == RoutePaths.onboarding ||
        path.startsWith('${RoutePaths.onboarding}/');

    if (!complete && !onOnboarding) {
      return RoutePaths.onboarding;
    }
    if (complete && onOnboarding) {
      return RoutePaths.tasks;
    }
    return null;
  }
}
