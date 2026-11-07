// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hinge_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Where hinge state comes from on this platform. Android and Windows hinges
/// arrive through the engine's display features; only iOS needs a channel.

@ProviderFor(hingeSource)
final hingeSourceProvider = HingeSourceProvider._();

/// Where hinge state comes from on this platform. Android and Windows hinges
/// arrive through the engine's display features; only iOS needs a channel.

final class HingeSourceProvider
    extends $FunctionalProvider<HingeSource, HingeSource, HingeSource>
    with $Provider<HingeSource> {
  /// Where hinge state comes from on this platform. Android and Windows hinges
  /// arrive through the engine's display features; only iOS needs a channel.
  HingeSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hingeSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hingeSourceHash();

  @$internal
  @override
  $ProviderElement<HingeSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HingeSource create(Ref ref) {
    return hingeSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HingeSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HingeSource>(value),
    );
  }
}

String _$hingeSourceHash() => r'2dad81de4e9e171e092fb4b83ec6854df46efa58';

/// Current hinge status, updated as the device folds or unfolds.

@ProviderFor(hingeStatus)
final hingeStatusProvider = HingeStatusProvider._();

/// Current hinge status, updated as the device folds or unfolds.

final class HingeStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<HingeStatus>,
          HingeStatus,
          Stream<HingeStatus>
        >
    with $FutureModifier<HingeStatus>, $StreamProvider<HingeStatus> {
  /// Current hinge status, updated as the device folds or unfolds.
  HingeStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hingeStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hingeStatusHash();

  @$internal
  @override
  $StreamProviderElement<HingeStatus> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<HingeStatus> create(Ref ref) {
    return hingeStatus(ref);
  }
}

String _$hingeStatusHash() => r'8df2f1164d3cb1d152b190b30e1699664a1c4c61';
