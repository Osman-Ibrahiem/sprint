import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_colors.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.green900,
      child: SizedBox.expand(child: child),
    );
  }
}
