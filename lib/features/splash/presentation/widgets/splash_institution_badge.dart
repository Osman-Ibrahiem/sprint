import 'package:flutter/material.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/core/theme/app_typography.dart';

class SplashInstitutionBadge extends StatelessWidget {
  const SplashInstitutionBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final labelStyle = AppTypography.xs.copyWith(
      fontWeight: AppTypography.semiBold,
      color: AppColors.textSecondary,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.sprintGreen.withValues(alpha: 0.2),
        border: Border.all(color: AppColors.sprintGreen.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.splashUniversity, style: labelStyle),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.lime.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(l10n.splashFaculty, style: labelStyle),
        ],
      ),
    );
  }
}
