import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:flux/features/onboarding/presentation/screens/onboarding_welcome_screen.dart';
import 'package:flux/features/onboarding/presentation/viewmodels/onboarding_welcome_view_model.dart';

import '../fakes/fake_onboarding_repository.dart';

void main() {
  testWidgets('shows exact headline, subtitle, Começar and Pular', (tester) async {
    final viewModel = _viewModel();

    await tester.pumpWidget(_wrap(OnboardingWelcomeScreen(viewModel: viewModel)));

    expect(find.text(OnboardingWelcomeScreen.headline), findsOneWidget);
    expect(find.text(OnboardingWelcomeScreen.subtitle), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);
    expect(find.text('Pular'), findsOneWidget);
  });

  testWidgets('tap Começar invokes start callback', (tester) async {
    var startCalled = false;
    final viewModel = _viewModel(onNavigateToTriage: () => startCalled = true);

    await tester.pumpWidget(_wrap(OnboardingWelcomeScreen(viewModel: viewModel)));

    await tester.tap(find.text('Começar'));
    await tester.pump();
    expect(startCalled, isTrue);
  });

  testWidgets('tap Pular invokes skip callback', (tester) async {
    var skipCalled = false;
    final viewModel = _viewModel(
      onAfterComplete: () async => skipCalled = true,
    );

    await tester.pumpWidget(_wrap(OnboardingWelcomeScreen(viewModel: viewModel)));

    await tester.tap(find.text('Pular'));
    await tester.pump();
    expect(skipCalled, isTrue);
  });
}

Widget _wrap(Widget child) {
  return MaterialApp(
    home: MediaQuery(
      data: const MediaQueryData(
        size: Size(800, 1200),
        disableAnimations: true,
      ),
      child: child,
    ),
  );
}

OnboardingWelcomeViewModel _viewModel({
  void Function()? onNavigateToTriage,
  Future<void> Function()? onAfterComplete,
}) {
  return OnboardingWelcomeViewModel(
    completeOnboarding:
        CompleteOnboardingUseCase(FakeOnboardingRepository()),
    onNavigateToTriage: onNavigateToTriage ?? () {},
    onAfterComplete: onAfterComplete ?? () async {},
  );
}
