import 'dart:ui';

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
        // Elliptical lime glow — subtle shadow, lower-center of screen.
        // sigmaX >> sigmaY ensures a wide flat ellipse, not a circle.
        Align(
          alignment: const Alignment(0, 0.48),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 36, sigmaY: 14),
            child: Container(
              width: 100,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.lime.withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ],
    );
  }
}