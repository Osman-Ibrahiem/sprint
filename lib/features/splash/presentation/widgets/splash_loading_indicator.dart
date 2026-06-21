import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_colors.dart';

class SplashLoadingIndicator extends StatelessWidget {
  const SplashLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        color: AppColors.lime.withValues(alpha: 0.6),
      ),
    );
  }
}
