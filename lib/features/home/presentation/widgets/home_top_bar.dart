import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/presentation/widgets/bolt_mark.dart';
import 'package:sprint/core/router/app_routes.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/core/theme/app_typography.dart';
import 'package:sprint/features/home/presentation/home_layout.dart';

/// Guest top bar: brand on the start side, sign-in link on the end side.
class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final type = AdaptiveTypography.of(PaneScope.of(context));

    return SizedBox(
      height: HomeLayout.topBarHeight,
      child: Row(
        children: [
          ExcludeSemantics(
            child: Container(
              width: HomeLayout.logoTile,
              height: HomeLayout.logoTile,
              decoration: const BoxDecoration(
                color: AppColors.sprintGreen,
                borderRadius: AppRadius.mdAll,
              ),
              alignment: Alignment.center,
              child: const BoltMark(
                width: HomeLayout.boltWidth,
                color: AppColors.accent,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            l10n.appName,
            style: type.h3.copyWith(
              color: AppColors.accent,
              fontWeight: AppTypography.black,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => context.go(AppRoutes.login),
            style: TextButton.styleFrom(foregroundColor: AppColors.accent),
            child: Text(
              l10n.homeGuestSignIn,
              style: type.body.copyWith(fontWeight: AppTypography.bold),
            ),
          ),
        ],
      ),
    );
  }
}
