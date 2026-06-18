import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/core/theme/app_typography.dart';

// Figma-spec dimensions for the progress indicator section.
const double _kBarWidth = 200;
const double _kBarHeight = 3;
const double _kCheckSize = 36;
const double _kCheckIconSize = 16;
// 8dp top padding on the progress container matches Figma node 5:28 padding-top.
const double _kBarTopPad = AppSpacing.sm;

class SplashProgressBar extends StatelessWidget {
  const SplashProgressBar({
    required this.progressAnim,
    required this.checkAnim,
    super.key,
  });

  final Animation<double> progressAnim;
  final Animation<double> checkAnim;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: _kBarTopPad),
        // Progress track + animated fill
        SizedBox(
          width: _kBarWidth,
          height: _kBarHeight,
          child: AnimatedBuilder(
            animation: progressAnim,
            builder: (context, _) => LinearProgressIndicator(
              value: progressAnim.value,
              backgroundColor: AppColors.white.withValues(alpha: 0.08),
              valueColor: const AlwaysStoppedAnimation(AppColors.lime),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              minHeight: _kBarHeight,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // Counting percentage label
        AnimatedBuilder(
          animation: progressAnim,
          builder: (context, _) {
            final pct = (progressAnim.value * 100).round();
            return Text(
              '$pct%',
              style: AppTypography.micro.copyWith(
                fontWeight: AppTypography.bold,
                color: AppColors.lime.withValues(alpha: 0.6),
                letterSpacing: 0.88,
              ),
            );
          },
        ),
        const SizedBox(height: AppSpacing.xl),
        // Check circle — fades in when progress completes
        FadeTransition(
          opacity: checkAnim,
          child: Container(
            width: _kCheckSize,
            height: _kCheckSize,
            decoration: BoxDecoration(
              color: AppColors.lime.withValues(alpha: 0.12),
              border: Border.all(color: AppColors.lime.withValues(alpha: 0.4)),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: const Icon(
              Icons.check_rounded,
              size: _kCheckIconSize,
              color: AppColors.lime,
            ),
          ),
        ),
      ],
    );
  }
}
