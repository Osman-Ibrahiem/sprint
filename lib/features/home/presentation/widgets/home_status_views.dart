import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_filled_button.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_spinner.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_spacing.dart';

/// Centered adaptive spinner while Home content loads.
class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(child: AdaptiveSpinner(color: AppColors.accent));
}

/// Failure message with a retry button.
class HomeErrorView extends StatelessWidget {
  const HomeErrorView({required this.onRetry, super.key});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = PaneScope.tokensOf(context);
    final type = AdaptiveTypography.of(PaneScope.of(context));

    return Center(
      child: Padding(
        padding: EdgeInsets.all(tokens.margin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.homeErrorMessage,
              textAlign: TextAlign.center,
              style: type.body.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: AppSpacing.lg),
            AdaptiveFilledButton(label: l10n.homeRetry, onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}

/// Body of navigation destinations that are not built yet.
class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key});

  @override
  Widget build(BuildContext context) {
    final type = AdaptiveTypography.of(PaneScope.of(context));
    return Center(
      child: Text(
        AppLocalizations.of(context)!.homeComingSoon,
        style: type.bodyLg.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
