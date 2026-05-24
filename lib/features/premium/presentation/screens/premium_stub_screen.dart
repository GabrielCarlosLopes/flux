import 'package:flutter/material.dart';

import '../../../../shared/widgets/feature_stub_screen.dart';

class PremiumStubScreen extends StatelessWidget {
  const PremiumStubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeatureStubScreen(
      featureTitle: 'Premium',
      areaLabel: 'Área: Premium — em construção',
    );
  }
}
