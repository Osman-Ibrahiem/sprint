import 'package:flutter/foundation.dart';

/// Debug aid: force the platform look with
/// `--dart-define=SPRINT_PLATFORM=ios|android|macos|windows|linux`.
/// Unset (the default) keeps the real platform.
abstract final class PlatformOverride {
  static const String _raw = String.fromEnvironment('SPRINT_PLATFORM');

  /// Override taken from the build environment, or null.
  static TargetPlatform? get current => parse(_raw);

  static TargetPlatform? parse(String value) => switch (value) {
    'ios' => TargetPlatform.iOS,
    'android' => TargetPlatform.android,
    'macos' => TargetPlatform.macOS,
    'windows' => TargetPlatform.windows,
    'linux' => TargetPlatform.linux,
    _ => null,
  };
}
