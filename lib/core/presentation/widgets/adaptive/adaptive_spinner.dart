import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_metrics.dart';
import 'package:sprint/core/adaptive/app_platform.dart';

/// Apple: 12-spoke activity indicator. Material: arc indicator.
class AdaptiveSpinner extends StatelessWidget {
  const AdaptiveSpinner({
    required this.color,
    this.size = SpinnerMetrics.size,
    this.strokeWidth = SpinnerMetrics.materialStroke,
    super.key,
  });

  final Color color;
  final double size;

  /// Arc thickness (Material only).
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    if (AppPlatform.of(context).isApple) {
      return SizedBox.square(
        dimension: size,
        child: CupertinoActivityIndicator(radius: size / 2, color: color),
      );
    }
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(strokeWidth: strokeWidth, color: color),
    );
  }
}
