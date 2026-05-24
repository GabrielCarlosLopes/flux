import 'package:flutter_test/flutter_test.dart';
import 'package:flux/app.dart';
import 'package:flux/core/navigation/app_router.dart';
import 'package:flux/core/navigation/route_paths.dart';

import 'helpers/onboarding_test_harness.dart';

void main() {
  setUpAll(initIsarTestCore);

  setUp(() async {
    await setupOnboardingHarness(markComplete: true);
    AppRouter.router.go(RoutePaths.tasks);
  });

  tearDown(tearDownOnboardingHarness);

  testWidgets('Flux shell loads without counter demo', (tester) async {
    await tester.pumpWidget(const FluxApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Flutter Demo'), findsNothing);
    expect(find.textContaining('em construção'), findsOneWidget);
  });
}
