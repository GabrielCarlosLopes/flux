import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_spacing.dart';
import 'stub_navigation_menu.dart';

/// Calm placeholder screen for feature areas under construction.
class FeatureStubScreen extends StatelessWidget {
  const FeatureStubScreen({
    super.key,
    required this.featureTitle,
    required this.areaLabel,
  });

  final String featureTitle;
  final String areaLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final path = GoRouterState.of(context).uri.path;

    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          header: true,
          child: Text(featureTitle),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.containerMarginMobile),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: 'Rota atual: $path',
                child: Text(
                  areaLabel,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Rota: $path',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Tema primário (Sage)',
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Serene Focus',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sectionGap),
              Text(
                'Navegação',
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              const StubNavigationMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
