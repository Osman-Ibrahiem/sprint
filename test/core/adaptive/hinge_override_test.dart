import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/adaptive/flex_posture.dart';
import 'package:sprint/core/adaptive/hinge_override.dart';

void main() {
  const media = MediaQueryData(size: Size(890, 626));

  test('vertical adds a centred vertical hinge', () {
    final m = HingeOverride.apply(media, 'vertical');
    final split = VerticalSplit.of(m)!;
    expect(split.leftWidth, 435);
    expect(split.rightStart, 455);
    expect(FlexPosture.of(m), isNull);
  });

  test('horizontal adds a centred horizontal hinge', () {
    final f = FlexPosture.of(HingeOverride.apply(media, 'horizontal'))!;
    expect(f.topHeight, 303);
    expect(f.bottomStart, 323);
  });

  test('anything else leaves the media untouched', () {
    expect(HingeOverride.apply(media, '').displayFeatures, isEmpty);
    expect(HingeOverride.apply(media, 'x').displayFeatures, isEmpty);
    expect(HingeOverride.current, '');
  });
}
