import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Step 2 of 2 — ~40% progress arc (48×48 dp).
class OnboardingProgressRing extends StatelessWidget {
  const OnboardingProgressRing({super.key});

  static const double _size = 48;
  static const double _progress = 0.4;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final trackColor = brightness == Brightness.light
        ? AppColors.surfaceContainer
        : AppColors.darkSurfaceContainer;
    final progressColor =
        brightness == Brightness.light ? AppColors.primary : AppColors.darkPrimary;

    return Semantics(
      label: 'Passo 2 de 2',
      child: SizedBox(
        width: _size,
        height: _size,
        child: CustomPaint(
          painter: _ProgressRingPainter(
            progress: _progress,
            trackColor: trackColor,
            progressColor: progressColor,
          ),
        ),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  _ProgressRingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
  });

  final double progress;
  final Color trackColor;
  final Color progressColor;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 6.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final sweep = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      sweep,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor;
  }
}
