import 'dart:ui' show DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/widgets.dart';

/// Half-open ("Flex mode") posture on a foldable with a horizontal hinge.
/// Content above the hinge is [topHeight] tall; the usable bottom half starts
/// at [bottomStart]. Flat or hinge-less devices yield null.
class FlexPosture {
  const FlexPosture({required this.topHeight, required this.bottomStart});

  final double topHeight;
  final double bottomStart;

  static FlexPosture? of(MediaQueryData media) {
    for (final feature in media.displayFeatures) {
      final isHinge =
          feature.type == DisplayFeatureType.hinge ||
          feature.type == DisplayFeatureType.fold;
      final isHalfOpen = feature.state == DisplayFeatureState.postureHalfOpened;
      final isHorizontal = feature.bounds.width > feature.bounds.height;
      if (isHinge && isHalfOpen && isHorizontal) {
        return FlexPosture(
          topHeight: feature.bounds.top,
          bottomStart: feature.bounds.bottom,
        );
      }
    }
    return null;
  }
}
