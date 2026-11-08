import 'package:flutter/widgets.dart';
import 'package:sprint/core/adaptive/size_class.dart';
import 'package:sprint/core/theme/app_spacing.dart';

/// Home-specific layout constants. Breakpoints are NOT defined here: the
/// column count follows the pane's [SizeClass] (constitution VI).
abstract final class HomeLayout {
  /// Width of the extended navigation rail (large windows).
  static const double extendedRailWidth = 240;

  /// Brand tile in the guest top bar and the bolt inside it.
  static const double logoTile = 36;
  static const double boltWidth = 14;
  static const double topBarHeight = 64;

  /// Facility card: art block height, text block height (scaled with the
  /// user's text scale), art icon size and badge inset.
  static const double cardArtHeight = 96;
  static const double cardInfoHeight = 128;
  static const double cardArtIconSize = 40;

  /// Gap between grid cells and between sections.
  static const double gridGap = AppSpacing.lg;
  static const double sectionGap = AppSpacing.xxl;

  /// Facility columns for a pane of class [sizeClass].
  static int columnsFor(SizeClass sizeClass) => switch (sizeClass) {
    SizeClass.compact => 1,
    SizeClass.medium => 2,
    SizeClass.expanded || SizeClass.large => 3,
  };

  /// Card height for the given text scale.
  static double cardExtent(TextScaler scaler) =>
      cardArtHeight + scaler.scale(cardInfoHeight);
}
