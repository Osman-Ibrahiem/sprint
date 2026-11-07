import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_metrics.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/app_platform.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_spinner.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';
import 'package:sprint/core/theme/app_typography.dart';

/// Primary lime button. Apple: capsule, 50 dp. Material: 12 dp radius, 52 dp.
/// While [isLoading] the label is replaced by a spinner and taps are ignored;
/// size does not change.
class AdaptiveFilledButton extends StatelessWidget {
  const AdaptiveFilledButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final platform = AppPlatform.of(context);
    final metrics = ButtonMetrics.of(platform);
    final type = AdaptiveTypography.of(PaneScope.of(context));
    final shape = platform.isApple
        ? const StadiumBorder()
        : const RoundedRectangleBorder(borderRadius: AppRadius.mdAll);

    return SizedBox(
      height: metrics.height,
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
          disabledBackgroundColor: AppColors.accentAlpha40,
          disabledForegroundColor: AppColors.onAccent,
          minimumSize: Size.fromHeight(metrics.height),
          padding: EdgeInsets.zero,
          shape: shape,
        ),
        child: isLoading
            ? const AdaptiveSpinner(color: AppColors.onAccent)
            : Text(
                label,
                style: type.bodyLg.copyWith(
                  fontWeight: platform.isApple
                      ? AppTypography.bold
                      : AppTypography.black,
                ),
              ),
      ),
    );
  }
}
