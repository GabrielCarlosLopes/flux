import 'package:flutter/material.dart';

import 'app.dart';
import 'core/navigation/app_router.dart';
import 'core/navigation/onboarding_redirect_notifier.dart';
import 'core/services/database_service.dart';
import 'features/onboarding/onboarding_scope.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.init();

  final redirectNotifier = OnboardingRedirectNotifier(
    OnboardingScope.isCompleteUseCase(),
  );
  await redirectNotifier.load();
  AppRouter.bind(redirectNotifier);

  runApp(const FluxApp());
}
