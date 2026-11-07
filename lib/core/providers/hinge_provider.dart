import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprint/core/adaptive/hinge_source.dart';
import 'package:sprint/core/adaptive/ios_hinge_source.dart';

part 'hinge_provider.g.dart';

/// Where hinge state comes from on this platform. Android and Windows hinges
/// arrive through the engine's display features; only iOS needs a channel.
@riverpod
HingeSource hingeSource(Ref ref) {
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
    return IosHingeSource();
  }
  return const NoHingeSource();
}

/// Current hinge status, updated as the device folds or unfolds.
@riverpod
Stream<HingeStatus> hingeStatus(Ref ref) =>
    ref.watch(hingeSourceProvider).watch();
