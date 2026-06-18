import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_colors.dart';

class SplashGlow extends StatelessWidget {
  const SplashGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Large green radial glow — screen-centered, atmospheric depth behind logo.
        //
        // Figma node 18:38: 480×480 circle at left:-43.25, top:186.1 on a
        // 393.5×852.2 screen → center at (196.75, 426.1) = exact screen center.
        // SVG gradientTransform matrix gives actual gradient radius = 339.41dp.
        // Flutter radius = 339.41 / 393 (shortest side) = 0.864.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.864,
              colors: [
                AppColors.sprintGreen.withValues(alpha: 0.35),
                AppColors.green900.withValues(alpha: 0),
              ],
              stops: const [0.0, 0.7],
            ),
          ),
          child: const SizedBox.expand(),
        ),
        // Small lime/olive glow — below the progress section.
        //
        // Figma node 18:39: left:36.75, top:604.38, width:320, height:120.
        // Three-stop gradient (matches Figma SVG exactly):
        //   stop 0:    rgba(204,244,43, 0.12)  — lime
        //   stop 0.35: rgba(102,122,22, 0.06)  — darker olive (0x0F = ~6% alpha)
        //   stop 0.7:  transparent
        Positioned(
          left: 36,
          right: 36,
          top: 604,
          height: 120,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  AppColors.lime.withValues(alpha: 0.12),
                  const Color(0x0F666A16),
                  const Color(0x00000000),
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