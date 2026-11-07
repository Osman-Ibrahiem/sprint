import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/presentation/widgets/bolt_mark.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/features/auth/presentation/login_layout.dart';

class LoginBrandHeader extends StatelessWidget {
  const LoginBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final type = AdaptiveTypography.of(PaneScope.of(context));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExcludeSemantics(
          child: Container(
            width: LoginLayout.logoTile,
            height: LoginLayout.logoTile,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.sprintGreen,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: const BoltMark(
              width: LoginLayout.boltWidth,
              color: AppColors.lime,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.appName,
          style: type.h1.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.loginTitle,
          textAlign: TextAlign.center,
          style: type.body.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
