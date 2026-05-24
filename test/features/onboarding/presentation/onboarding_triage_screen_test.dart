import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux/features/onboarding/domain/entities/triage_challenge.dart';
import 'package:flux/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:flux/features/onboarding/presentation/screens/onboarding_triage_screen.dart';
import 'package:flux/features/onboarding/presentation/viewmodels/onboarding_triage_view_model.dart';

import '../fakes/fake_onboarding_repository.dart';

void main() {
  Widget buildScreen(OnboardingTriageViewModel viewModel) {
    return MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(
          size: Size(800, 1200),
          disableAnimations: true,
        ),
        child: OnboardingTriageScreen(
          viewModel: viewModel,
          onBack: () {},
        ),
      ),
    );
  }

  OnboardingTriageViewModel viewModel({Future<void> Function()? onAfterComplete}) {
    return OnboardingTriageViewModel(
      completeOnboarding:
          CompleteOnboardingUseCase(FakeOnboardingRepository()),
      onAfterComplete: onAfterComplete ?? () async {},
    );
  }

  testWidgets('shows five option labels and Pular', (tester) async {
    final vm = viewModel();
    await tester.pumpWidget(buildScreen(vm));

    for (final challenge in TriageChallenge.values) {
      expect(find.text(challenge.label), findsOneWidget);
    }
    expect(find.text('Pular'), findsOneWidget);
    expect(find.bySemanticsLabel('Voltar'), findsOneWidget);
  });

  testWidgets('Continuar disabled until selection', (tester) async {
    final vm = viewModel();
    await tester.pumpWidget(buildScreen(vm));

    final continueButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Continuar'),
    );
    expect(continueButton.onPressed, isNull);

    await tester.tap(find.text(TriageChallenge.procrastination.label));
    await tester.pump();

    final enabledButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Continuar'),
    );
    expect(enabledButton.onPressed, isNotNull);

    await tester.tap(find.text(TriageChallenge.procrastination.label));
    await tester.pump();

    final disabledAgain = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Continuar'),
    );
    expect(disabledAgain.onPressed, isNull);
  });

  testWidgets('selected card updates view model state', (tester) async {
    final vm = viewModel();
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(buildScreen(vm));

    await tester.tap(find.byKey(ValueKey(TriageChallenge.procrastination.id)));
    await tester.pump();

    expect(vm.isSelected(TriageChallenge.procrastination), isTrue);
  });

  testWidgets('back button is 48x48', (tester) async {
    final vm = viewModel();
    await tester.pumpWidget(buildScreen(vm));

    final back = find.bySemanticsLabel('Voltar');
    expect(tester.getSize(back), const Size(48, 48));
  });
}
