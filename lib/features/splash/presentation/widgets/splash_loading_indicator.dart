import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_metrics.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_spinner.dart';
import 'package:sprint/core/theme/app_colors.dart';

class SplashLoadingIndicator extends StatelessWidget {
  const SplashLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdaptiveSpinner(
      color: AppColors.accentAlpha60,
      strokeWidth: SpinnerMetrics.materialStrokeThin,
    );
  }
}
