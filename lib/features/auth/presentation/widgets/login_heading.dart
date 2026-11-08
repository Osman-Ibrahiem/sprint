import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/features/auth/presentation/login_layout.dart';

/// Form-pane title and subtitle used in the two-pane layout.
class LoginHeading extends StatelessWidget {
  const LoginHeading({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final type = AdaptiveTypography.of(PaneScope.of(context));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.loginTitle,
          style: type.h2.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: LoginLayout.headingGap),
        Text(
          l10n.loginSubtitle,
          style: type.body.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
