import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux/app.dart';
import 'package:flux/core/navigation/app_router.dart';
import 'package:flux/core/navigation/route_paths.dart';
import 'package:flux/core/theme/app_colors.dart';
import '../helpers/onboarding_test_harness.dart';

void main() {
  setUpAll(() async {
    await initIsarTestCore();
    TestWidgetsFlutterBinding.ensureInitialized();
    TestWidgetsFlutterBinding
        .instance.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
  });

  setUp(() async {
    await setupOnboardingHarness(markComplete: true);
    AppRouter.router.go(RoutePaths.tasks);
  });

  tearDown(tearDownOnboardingHarness);

  testWidgets('FluxApp pumps tasks stub home', (tester) async {
    await tester.pumpWidget(const FluxApp());
    await tester.pump();

    expect(find.textContaining('Área: Tarefas'), findsOneWidget);
  });

  testWidgets('light theme primary matches AppColors.primary', (tester) async {
    await tester.pumpWidget(const FluxApp());
    await tester.pump();

    final context = tester.element(find.textContaining('Área: Tarefas'));
    final primary = Theme.of(context).colorScheme.primary;
    expect(primary, AppColors.primary);
  });

  testWidgets('dark theme uses Brightness.dark', (tester) async {
    addTearDown(() {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    });
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;

    await tester.pumpWidget(const FluxApp());
    await tester.pump();
    AppRouter.router.go(RoutePaths.tasks);
    await tester.pump();

    final materialApp = tester.widget<MaterialApp>(
      find.byWidgetPredicate((w) => w is MaterialApp && w.routerConfig != null),
    );
    expect(materialApp.darkTheme?.brightness, Brightness.dark);

    final context = tester.element(find.textContaining('Área: Tarefas'));
    expect(Theme.of(context).brightness, Brightness.dark);
  });
}
