import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Test binding that lets widget tests run under a simulated device
/// (see the device_preview README, "Testing under a simulated device").
class TestDevicePreviewBinding extends AutomatedTestWidgetsFlutterBinding
    with DevicePreviewBindingMixin {
  static TestDevicePreviewBinding? _instance;

  static TestDevicePreviewBinding ensureInitialized({
    DeviceSimulation? initialSimulation,
  }) {
    if (_instance == null) {
      DevicePreviewBindingMixin.latchConfiguration(
        enabled: true,
        initialSimulation: initialSimulation,
      );
      TestDevicePreviewBinding();
    }
    return _instance!;
  }

  @override
  void initInstances() {
    super.initInstances();
    _instance = this;
  }

  @override
  Widget wrapWithDefaultView(Widget rootWidget) {
    final ui.FlutterView? wrapperView = previewImplicitView;
    final controller = devicePreview;
    if (wrapperView != null) {
      return View(
        view: wrapperView,
        child: controller == null
            ? rootWidget
            : DevicePreviewFrame(
                simulation: controller.simulationListenable,
                child: rootWidget,
              ),
      );
    }
    return super.wrapWithDefaultView(rootWidget);
  }
}
