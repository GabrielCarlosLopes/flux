import 'package:flutter/material.dart';

import '../../../../shared/widgets/feature_stub_screen.dart';

class TasksStubScreen extends StatelessWidget {
  const TasksStubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeatureStubScreen(
      featureTitle: 'Tarefas',
      areaLabel: 'Área: Tarefas — em construção',
    );
  }
}
