import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/widgets.dart';

/// Whether [feature] physically or visually divides the screen: a dual-screen
/// hinge (always, even when flat — the gap is there) or a fold that is
/// half-open. A flat, seamless fold (e.g. a Galaxy Fold unfolded) does not.
bool _dividesScreen(DisplayFeature feature) {
  final isHinge = feature.type == DisplayFeatureType.hinge;
  final isBentFold =
      feature.type == DisplayFeatureType.fold &&
      feature.state == DisplayFeatureState.postureHalfOpened;
  return isHinge || isBentFold;
}

/// Screen split by a **horizontal** hinge/fold (top and bottom halves), e.g. a
/// flip phone in Flex mode or a dual-screen device in portrait. Content above
/// the hinge is [topHeight] tall; the usable bottom half starts at
/// [bottomStart]. Null when there is no such feature.
class FlexPosture {
  const FlexPosture({required this.topHeight, required this.bottomStart});

  final double topHeight;
  final double bottomStart;

  static FlexPosture? of(MediaQueryData media) {
    for (final feature in media.displayFeatures) {
      final isHorizontal = feature.bounds.width > feature.bounds.height;
      if (_dividesScreen(feature) && isHorizontal) {
        return FlexPosture(
          topHeight: feature.bounds.top,
          bottomStart: feature.bounds.bottom,
        );
      }
    }
    return null;
  }
}

/// Screen split by a **vertical** hinge/fold (left and right halves), e.g. a
/// dual-screen device in landscape. The left screen is [leftWidth] wide and
/// the right screen starts at [rightStart]; the gap between is the hinge.
class VerticalSplit {
  const VerticalSplit({required this.leftWidth, required this.rightStart});

  final double leftWidth;
  final double rightStart;

  static VerticalSplit? of(MediaQueryData media) {
    for (final feature in media.displayFeatures) {
      final isVertical = feature.bounds.height > feature.bounds.width;
      if (_dividesScreen(feature) && isVertical) {
        return VerticalSplit(
          leftWidth: feature.bounds.left,
          rightStart: feature.bounds.right,
        );
      }
    }
    return null;
  }
}
