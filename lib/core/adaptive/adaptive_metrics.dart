import 'package:sprint/core/adaptive/app_platform.dart';

/// Pixel metrics of the adaptive form controls, per platform.
/// Source: Figma `Login/Field` (15:44), `Login/Button` (15:49),
/// `Splash/Spinner` (20:705).
class FieldMetrics {
  const FieldMetrics({
    required this.height,
    required this.borderWidth,
    required this.focusedBorderWidth,
    required this.iconSize,
    required this.leadingBox,
    required this.trailingBox,
    required this.edgePadding,
    required this.gap,
    required this.hasRestingBorder,
  });

  final double height;
  final double borderWidth;
  final double focusedBorderWidth;
  final double iconSize;

  /// Tap/visual box around an icon on Material; 0 when icons sit inline.
  final double leadingBox;

  /// Tap target for an interactive trailing widget (e.g. visibility toggle).
  final double trailingBox;

  /// Padding at an edge that has no icon box.
  final double edgePadding;

  /// Gap between icon and text (Apple inline icons).
  final double gap;

  /// Material draws a 1 dp border at rest; Apple has none until focus/error.
  final bool hasRestingBorder;

  /// Space between the field box and its error caption.
  static const double captionGap = 4;

  /// Horizontal inset of the error caption.
  static const double captionInset = 16;

  static const FieldMetrics material = FieldMetrics(
    height: 56,
    borderWidth: 1,
    focusedBorderWidth: 2,
    iconSize: 24,
    leadingBox: 48,
    trailingBox: 48,
    edgePadding: 16,
    gap: 0,
    hasRestingBorder: true,
  );

  static const FieldMetrics apple = FieldMetrics(
    height: 50,
    borderWidth: 1,
    focusedBorderWidth: 1,
    iconSize: 20,
    leadingBox: 0,
    trailingBox: 44,
    edgePadding: 14,
    gap: 8,
    hasRestingBorder: false,
  );

  static FieldMetrics of(AppPlatform platform) =>
      platform.isApple ? apple : material;
}

/// Metrics of the primary filled button.
class ButtonMetrics {
  const ButtonMetrics({required this.height});

  final double height;

  static const ButtonMetrics material = ButtonMetrics(height: 52);
  static const ButtonMetrics apple = ButtonMetrics(height: 50);

  static ButtonMetrics of(AppPlatform platform) =>
      platform.isApple ? apple : material;
}

/// Spinner defaults (Figma spinner set 20:705 and Login/Button loading).
abstract final class SpinnerMetrics {
  static const double size = 20;
  static const double materialStroke = 2;
  static const double materialStrokeThin = 1.5;
}
