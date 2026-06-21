import 'package:flutter/material.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/core/theme/app_typography.dart';

class SplashAppName extends StatelessWidget {
  const SplashAppName({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.appName,
          textAlign: TextAlign.center,
          style: AppTypography.displayXl.copyWith(
            color: AppColors.textPrimary,
            letterSpacing: -0.48,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          l10n.splashTagline,
          textAlign: TextAlign.center,
          style: AppTypography.sm.copyWith(
            fontWeight: AppTypography.medium,
            color: AppColors.textSecondary,
            letterSpacing: 0.56,
          ),
        ),
      ],
    );
  }
}
