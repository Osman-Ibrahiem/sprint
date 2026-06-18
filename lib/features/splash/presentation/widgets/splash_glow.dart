import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_colors.dart';

class SplashGlow extends StatelessWidget {
  const SplashGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Large green radial glow — centered, atmospheric depth behind logo.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              // radius 1.22 ≈ 480dp diameter on a ~393dp-wide mobile screen,
              // matching the Figma glow circle dimensions.
              radius: 1.22,
              colors: [
                AppColors.sprintGreen.withValues(alpha: 0.35),
                AppColors.green900.withValues(alpha: 0),
              ],
              stops: const [0.0, 0.7],
            ),
          ),
          child: const SizedBox.expand(),
        ),
        // Lime radial glow — lower third of screen, under progress bar area.
        Positioned(
          left: 0,
          right: 0,
          bottom: 140,
          height: 120,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  AppColors.lime.withValues(alpha: 0.12),
                  AppColors.lime.withValues(alpha: 0.06),
                  AppColors.green900.withValues(alpha: 0),
                ],
                stops: const [0.0, 0.35, 0.7],
              ),
            ),
            child: const SizedBox.expand(),
          ),
        ),
      ],
    );
  }
}
