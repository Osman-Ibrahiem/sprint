import 'package:flutter/material.dart';

/// Visual language for adaptive widgets.
enum AppPlatform {
  /// iOS and macOS.
  apple,

  /// Android, Windows, Linux, Fuchsia.
  material;

  /// Read from `Theme.platform` so tests and a debug override can switch it.
  /// On web the target platform comes from the user agent.
  static AppPlatform of(BuildContext context) =>
      fromTargetPlatform(Theme.of(context).platform);

  static AppPlatform fromTargetPlatform(TargetPlatform platform) =>
      switch (platform) {
        TargetPlatform.iOS || TargetPlatform.macOS => apple,
        TargetPlatform.android ||
        TargetPlatform.windows ||
        TargetPlatform.linux ||
        TargetPlatform.fuchsia => material,
      };

  bool get isApple => this == apple;
}
