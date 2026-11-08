import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/adaptive/flex_posture.dart';

MediaQueryData _media(DisplayFeature f) =>
    MediaQueryData(size: const Size(412, 900), displayFeatures: [f]);

void main() {
  test('half-open horizontal hinge yields a posture', () {
    final p = FlexPosture.of(
      _media(
        const DisplayFeature(
          bounds: Rect.fromLTWH(0, 440, 412, 20),
          type: DisplayFeatureType.hinge,
          state: DisplayFeatureState.postureHalfOpened,
        ),
      ),
    );
    expect(p?.topHeight, 440);
    expect(p?.bottomStart, 460);
  });

  test('a flat dual-screen hinge still splits (the gap is physical)', () {
    final f = _media(
      const DisplayFeature(
        bounds: Rect.fromLTWH(0, 440, 412, 20),
        type: DisplayFeatureType.hinge,
        state: DisplayFeatureState.postureFlat,
      ),
    );
    expect(FlexPosture.of(f)?.bottomStart, 460);
  });

  test('vertical hinge yields a VerticalSplit, not a FlexPosture', () {
    final m = _media(
      const DisplayFeature(
        bounds: Rect.fromLTWH(435, 0, 20, 626),
        type: DisplayFeatureType.hinge,
        state: DisplayFeatureState.postureFlat,
      ),
    );
    expect(FlexPosture.of(m), isNull);
    expect(VerticalSplit.of(m)?.leftWidth, 435);
    expect(VerticalSplit.of(m)?.rightStart, 455);
  });

  test('flat, seamless folds or absent features are ignored', () {
    expect(FlexPosture.of(const MediaQueryData()), isNull);
    expect(
      FlexPosture.of(
        _media(
          const DisplayFeature(
            bounds: Rect.fromLTWH(0, 440, 412, 0),
            type: DisplayFeatureType.fold,
            state: DisplayFeatureState.postureFlat,
          ),
        ),
      ),
      isNull,
    );
    expect(
      FlexPosture.of(
        _media(
          const DisplayFeature(
            bounds: Rect.fromLTWH(200, 0, 20, 900),
            type: DisplayFeatureType.hinge,
            state: DisplayFeatureState.postureHalfOpened,
          ),
        ),
      ),
      isNull,
    );
  });
}
