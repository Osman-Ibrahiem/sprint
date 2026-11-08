import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/adaptive/app_platform.dart';

void main() {
  test('maps target platforms', () {
    expect(
      AppPlatform.fromTargetPlatform(TargetPlatform.iOS),
      AppPlatform.apple,
    );
    expect(
      AppPlatform.fromTargetPlatform(TargetPlatform.macOS),
      AppPlatform.apple,
    );
    for (final p in [
      TargetPlatform.android,
      TargetPlatform.windows,
      TargetPlatform.linux,
      TargetPlatform.fuchsia,
    ]) {
      expect(AppPlatform.fromTargetPlatform(p), AppPlatform.material);
    }
  });

  for (final entry in {
    TargetPlatform.iOS: AppPlatform.apple,
    TargetPlatform.android: AppPlatform.material,
  }.entries) {
    testWidgets('of(context) reads Theme.platform ${entry.key}', (
      tester,
    ) async {
      AppPlatform? seen;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: entry.key),
          home: Builder(
            builder: (context) {
              seen = AppPlatform.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(seen, entry.value);
    });
  }
}
