import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_typography.dart';

/// Booker greeting by name.
class HomeGreeting extends StatelessWidget {
  const HomeGreeting({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final type = AdaptiveTypography.of(PaneScope.of(context));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.homeGreeting(name),
          style: type.h2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: AppTypography.black,
          ),
        ),
        Text(
          l10n.homeGreetingSubtitle,
          style: type.body.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
