import 'package:device_preview/presets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/adaptive/app_platform.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_text_field.dart';
import 'package:sprint/core/theme/app_theme.dart';

import 'device_preview_binding.dart';

Widget _app() => MaterialApp(
  theme: AppTheme.dark(),
  home: const Scaffold(
    body: Center(child: AdaptiveTextField(hintText: 'h')),
  ),
);

void main() {
  final binding = TestDevicePreviewBinding.ensureInitialized();

  testWidgets('target platform iOS gives the Apple look', (tester) async {
    final c = binding.devicePreview!;
    await c.applyPreset(DevicePresets.iPhone16);
    // Applying a platform reassembles the app, which needs frames to pump.
    final applied = c.update(
      (s) => s.copyWith(targetPlatform: TargetPlatform.iOS),
    );
    await tester.pump();
    await applied;
    await tester.pumpWidget(_app());
    final ctx = tester.element(find.byType(AdaptiveTextField));
    expect(AppPlatform.of(ctx), AppPlatform.apple);
    expect(tester.getSize(find.byType(AdaptiveTextField)).height, 50);
    // flutter_test requires this debug variable to be unset when a test ends.
    debugDefaultTargetPlatformOverride = null;
  });

  testWidgets('target platform Android gives the Material look', (
    tester,
  ) async {
    final c = binding.devicePreview!;
    await c.applyPreset(DevicePresets.pixel10);
    final applied = c.update(
      (s) => s.copyWith(targetPlatform: TargetPlatform.android),
    );
    await tester.pump();
    await applied;
    await tester.pumpWidget(_app());
    final ctx = tester.element(find.byType(AdaptiveTextField));
    expect(AppPlatform.of(ctx), AppPlatform.material);
    expect(tester.getSize(find.byType(AdaptiveTextField)).height, 56);
    debugDefaultTargetPlatformOverride = null;
  });
}
