import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/widgets.dart';

/// Debug aid for devices Flutter cannot report a hinge for (web, desktop,
/// simulators): `--dart-define=SPRINT_HINGE=vertical|horizontal` adds a
/// centred hinge of [gap] dp to the window. Unset keeps the real features.
abstract final class HingeOverride {
  static const String _raw = String.fromEnvironment('SPRINT_HINGE');

  /// Width of the simulated hinge gap, in dp.
  static const double gap = 20;

  static String get current => _raw;

  /// Returns [media] with a simulated centred hinge for [mode]
  /// (`vertical` or `horizontal`), or unchanged for anything else.
  static MediaQueryData apply(MediaQueryData media, String mode) {
    final size = media.size;
    final Rect bounds;
    switch (mode) {
      case 'vertical':
        bounds = Rect.fromLTWH((size.width - gap) / 2, 0, gap, size.height);
      case 'horizontal':
        bounds = Rect.fromLTWH(0, (size.height - gap) / 2, size.width, gap);
      default:
        return media;
    }
    return media.copyWith(
      displayFeatures: [
        DisplayFeature(
          bounds: bounds,
          type: DisplayFeatureType.hinge,
          state: DisplayFeatureState.postureFlat,
        ),
      ],
    );
  }
}
