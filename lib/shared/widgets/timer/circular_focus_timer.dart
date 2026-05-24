import 'package:flutter/material.dart';

import 'focus_timer_controller.dart';

class CircularFocusTimer extends StatelessWidget {
  final FocusTimerController controller;
  final double size;
  final Color activeColor;
  final Color backgroundColor;

  const CircularFocusTimer({
    super.key,
    required this.controller,
    this.size = 240.0,
    this.activeColor = Colors.blueAccent, // Deve vir do Tema Serene Focus (F00)
    this.backgroundColor = Colors.black12,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      // O ValueListenableBuilder garante que APENAS este widget reconstrói a cada segundo
      child: ValueListenableBuilder<int>(
        valueListenable: controller.remainingSeconds,
        builder: (context, seconds, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: controller.progress,
                strokeWidth: 12.0,
                color: activeColor,
                backgroundColor: backgroundColor,
                strokeCap: StrokeCap.round,
              ),
              Center(
                child: Text(
                  controller.formattedTime,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
