import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/adaptive/platform_override.dart';

void main() {
  test('parses known platforms, ignores everything else', () {
    expect(PlatformOverride.parse('ios'), TargetPlatform.iOS);
    expect(PlatformOverride.parse('android'), TargetPlatform.android);
    expect(PlatformOverride.parse('macos'), TargetPlatform.macOS);
    expect(PlatformOverride.parse('windows'), TargetPlatform.windows);
    expect(PlatformOverride.parse('linux'), TargetPlatform.linux);
    expect(PlatformOverride.parse(''), isNull);
    expect(PlatformOverride.parse('beos'), isNull);
  });

  test('no override by default', () {
    expect(PlatformOverride.current, isNull);
  });
}
