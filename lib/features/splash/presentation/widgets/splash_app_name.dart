import 'package:flutter/material.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
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
          style: AppTypography.display.copyWith(
            fontSize: 44,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.splashSubtitle,
          style: AppTypography.body.copyWith(
            fontWeight: AppTypography.semiBold,
            color: AppColors.green300,
          ),
        ),
      ],
    );
  }
}
