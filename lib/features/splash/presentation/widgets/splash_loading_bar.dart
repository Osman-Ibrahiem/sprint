import 'package:flutter/material.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_typography.dart';

class SplashLoadingBar extends StatelessWidget {
  const SplashLoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: SizedBox(
            width: 148,
            height: 4,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.08, end: 0.96),
              duration: const Duration(milliseconds: 1800),
              curve: Curves.linear,
              builder: (context, value, child) => LinearProgressIndicator(
                value: value,
                backgroundColor: AppColors.lime.withAlpha(40),
                valueColor: const AlwaysStoppedAnimation(AppColors.lime),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.splashContinueHint,
          style: AppTypography.xs.copyWith(
            fontWeight: AppTypography.semiBold,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
