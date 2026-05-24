import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Animated decorative orbs (breathe + float) — isolated rebuild via [AnimatedBuilder].
class OnboardingBlurOrbsBackground extends StatefulWidget {
  const OnboardingBlurOrbsBackground({super.key});

  @override
  State<OnboardingBlurOrbsBackground> createState() =>
      _OnboardingBlurOrbsBackgroundState();
}

class _OnboardingBlurOrbsBackgroundState
    extends State<OnboardingBlurOrbsBackground>
    with TickerProviderStateMixin {
  late final AnimationController _breatheController;
  late final AnimationController _floatController;
  late final Animation<double> _breatheScale;
  late final Animation<double> _breatheOpacity;
  late final Animation<double> _floatTranslateY;
  late final Animation<double> _floatOpacity;

  @override
  void initState() {
    super.initState();
    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);

    _breatheScale = Tween<double>(begin: 1, end: 1.1).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOut),
    );
    _breatheOpacity = Tween<double>(begin: 0.4, end: 0.6).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOut),
    );
    _floatTranslateY = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
    _floatOpacity = Tween<double>(begin: 0.3, end: 0.5).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _breatheController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (disableAnimations) {
      return const _StaticOrbs();
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedBuilder(
          animation: _breatheController,
          builder: (context, child) {
            return Positioned(
              top: -MediaQuery.sizeOf(context).height * 0.15,
              left: -MediaQuery.sizeOf(context).width * 0.1,
              child: Transform.scale(
                scale: _breatheScale.value,
                child: Opacity(
                  opacity: _breatheOpacity.value,
                  child: child,
                ),
              ),
            );
          },
          child: const _BlurredOrb(
            sizeFactor: 0.6,
            color: AppColors.primaryContainer,
            blurSigma: 100,
          ),
        ),
        AnimatedBuilder(
          animation: _floatController,
          builder: (context, child) {
            return Positioned(
              bottom: -MediaQuery.sizeOf(context).height * 0.2,
              right: -MediaQuery.sizeOf(context).width * 0.1,
              child: Transform.translate(
                offset: Offset(0, _floatTranslateY.value),
                child: Opacity(
                  opacity: _floatOpacity.value,
                  child: child,
                ),
              ),
            );
          },
          child: const _BlurredOrb(
            sizeFactor: 0.7,
            color: AppColors.secondaryContainer,
            blurSigma: 120,
            opacity: 0.3,
          ),
        ),
      ],
    );
  }
}

class _StaticOrbs extends StatelessWidget {
  const _StaticOrbs();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -size.height * 0.15,
          left: -size.width * 0.1,
          child: Opacity(
            opacity: 0.4,
            child: _BlurredOrb(
              diameter: size.width * 0.6,
              color: AppColors.primaryContainer.withValues(alpha: 0.4),
              blurSigma: 100,
            ),
          ),
        ),
        Positioned(
          bottom: -size.height * 0.2,
          right: -size.width * 0.1,
          child: Opacity(
            opacity: 0.3,
            child: _BlurredOrb(
              diameter: size.width * 0.7,
              color: AppColors.secondaryContainer.withValues(alpha: 0.3),
              blurSigma: 120,
            ),
          ),
        ),
      ],
    );
  }
}

class _BlurredOrb extends StatelessWidget {
  const _BlurredOrb({
    this.sizeFactor,
    required this.color,
    required this.blurSigma,
    this.opacity = 1,
    this.diameter,
  });

  final double? sizeFactor;
  final Color color;
  final double blurSigma;
  final double opacity;
  final double? diameter;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    final d = diameter ?? screen.width * (sizeFactor ?? 0.6);
  final maxD = screen.width < screen.height ? screen.width : screen.height;
    final clamped = d > maxD * 1.2 ? maxD * 1.2 : d;

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: clamped,
          height: clamped,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }
}
