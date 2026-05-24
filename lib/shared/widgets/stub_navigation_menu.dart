import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/navigation/route_paths.dart';

/// Navigation menu for stub screens — tests all feature routes.
class StubNavigationMenu extends StatelessWidget {
  const StubNavigationMenu({super.key});

  static const List<({String label, String path})> _destinations = [
    (label: 'Onboarding', path: RoutePaths.onboarding),
    (label: 'Tarefas', path: RoutePaths.tasks),
    (label: 'Foco', path: RoutePaths.focus),
    (label: 'Rotinas', path: RoutePaths.routines),
    (label: 'Insights', path: RoutePaths.insights),
    (label: 'Configurações', path: RoutePaths.settings),
    (label: 'Premium', path: RoutePaths.premium),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final dest in _destinations)
          Semantics(
            button: true,
            label: 'Ir para ${dest.label}',
            child: ListTile(
              title: Text(dest.label),
              onTap: () => context.go(dest.path),
            ),
          ),
      ],
    );
  }
}
