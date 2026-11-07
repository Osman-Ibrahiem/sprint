import 'package:sprint/core/theme/app_spacing.dart';

/// Login-specific layout constants (Figma page `Login`, 15:2).
abstract final class LoginLayout {
  /// Width of the form column.
  static const double formWidth = 480;

  /// Logo tile (brand header) and the bolt inside it.
  static const double logoTile = 48;
  static const double boltWidth = 18;

  static const double headerToForm = AppSpacing.xxxl;
  static const double headingToForm = AppSpacing.xxl;
  static const double fieldGap = AppSpacing.lg;
  static const double buttonTopGap = AppSpacing.sm;
  static const double paneVerticalPad = AppSpacing.xxl;
  static const double brandTitleGap = AppSpacing.xl;
  static const double headingGap = AppSpacing.xs;

  /// Brand-pane glow radius, as a fraction of its (pane-wide) square.
  static const double brandGlowRadius = 0.5;
}
