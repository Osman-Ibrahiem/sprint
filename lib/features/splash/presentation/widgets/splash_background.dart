import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_colors.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: [AppColors.green700, AppColors.green900],
          stops: [0.0, 0.62],
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}
