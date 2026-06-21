import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_institution_badge.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_loading_indicator.dart';

class SplashFooter extends StatelessWidget {
  const SplashFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SplashLoadingIndicator(),
        SizedBox(height: AppSpacing.lg),
        SplashInstitutionBadge(),
      ],
    );
  }
}
