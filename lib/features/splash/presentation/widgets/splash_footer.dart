import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_institution_badge.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_loading_indicator.dart';

/// Spinner above the institution badge. Short windows show the badge only.
class SplashFooter extends StatelessWidget {
  const SplashFooter({this.showSpinner = true, super.key});

  final bool showSpinner;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showSpinner) ...[
          const SplashLoadingIndicator(),
          const SizedBox(height: AppSpacing.lg),
        ],
        const FittedBox(fit: BoxFit.scaleDown, child: SplashInstitutionBadge()),
      ],
    );
  }
}
