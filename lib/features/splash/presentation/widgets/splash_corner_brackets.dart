import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_spacing.dart';

class SplashCornerBrackets extends StatelessWidget {
  const SplashCornerBrackets({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          left: AppSpacing.xl,
          top: AppSpacing.xl,
          child: _bracket(top: true, leading: true),
        ),
        Positioned(
          right: AppSpacing.xl,
          top: AppSpacing.xl,
          child: _bracket(top: true, leading: false),
        ),
        Positioned(
          left: AppSpacing.xl,
          bottom: AppSpacing.xl,
          child: _bracket(top: false, leading: true),
        ),
        Positioned(
          right: AppSpacing.xl,
          bottom: AppSpacing.xl,
          child: _bracket(top: false, leading: false),
        ),
      ],
    );
  }

  Widget _bracket({required bool top, required bool leading}) {
    final side = BorderSide(
      color: AppColors.lime.withValues(alpha: 0.25),
      width: 1,
    );
    return SizedBox(
      width: AppSpacing.xl,
      height: AppSpacing.xl,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: top ? side : BorderSide.none,
            bottom: top ? BorderSide.none : side,
            left: leading ? side : BorderSide.none,
            right: leading ? BorderSide.none : side,
          ),
        ),
      ),
    );
  }
}
