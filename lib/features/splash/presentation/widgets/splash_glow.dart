import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_colors.dart';

class SplashGlow extends StatelessWidget {
  const SplashGlow({super.key});

  @override
  Widget build(BuildContext context) {
    // Screen-centered atmospheric green gradient.
    //
    // Figma node 18:38: 480×480 circle at left:-43.25, top:186.1 on a
    // 393.5×852.2 screen → center at (196.75, 426.1) = exact screen center.
    // SVG gradientTransform gives actual gradient radius = 339.41dp.
    // Flutter radius = 339.41 / 393 (shortest side) = 0.864.
    //
    // Four-stop falloff replaces the original two-stop to eliminate the
    // abrupt edge ring that made the gradient read as a tight spotlight.
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.864,
          colors: [
            AppColors.sprintGreen.withValues(alpha: 0.40),
            AppColors.sprintGreen.withValues(alpha: 0.22),
            AppColors.sprintGreen.withValues(alpha: 0.06),
            AppColors.green900.withValues(alpha: 0),
          ],
          stops: const [0.0, 0.35, 0.65, 1.0],
        ),
      ),
      child: const SizedBox.expand(),
    );
  }
}
