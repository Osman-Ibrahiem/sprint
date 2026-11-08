import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_filled_button.dart';
import 'package:sprint/core/router/app_routes.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/core/theme/app_typography.dart';

/// Guest pitch: what Sprint does and a sign-in call to action.
class HomeHero extends StatelessWidget {
  const HomeHero({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final type = AdaptiveTypography.of(PaneScope.of(context));

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: AppColors.border),
        gradient: const LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [AppColors.sprintGreen, AppColors.bgSurface],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.homeGuestHeroTitle,
              style: type.h2.copyWith(
                color: AppColors.textPrimary,
                fontWeight: AppTypography.black,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.homeGuestHeroBody,
              style: type.body.copyWith(color: AppColors.green300),
            ),
            const SizedBox(height: AppSpacing.xl),
            AdaptiveFilledButton(
              label: l10n.homeGuestHeroCta,
              onPressed: () => context.go(AppRoutes.login),
            ),
          ],
        ),
      ),
    );
  }
}
