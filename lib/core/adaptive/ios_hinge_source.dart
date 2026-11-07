import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sprint/core/adaptive/hinge_source.dart';

/// Reads the foldable-iPhone hinge (iOS 27.1+) from the native side over the
/// `sprint/hinge` channel. Older iOS versions and non-foldable phones never
/// report a hinge and stay [HingeStatus.none].
class IosHingeSource implements HingeSource {
  IosHingeSource({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel(channelName);

  static const String channelName = 'sprint/hinge';

  final MethodChannel _channel;

  @override
  Stream<HingeStatus> watch() {
    final controller = StreamController<HingeStatus>();

    _channel.setMethodCallHandler((call) async {
      if (call.method == 'status') controller.add(_decode(call.arguments));
    });
    controller.onCancel = () => _channel.setMethodCallHandler(null);

    _channel
        .invokeMethod<int>('getStatus')
        .then((value) => controller.add(_decode(value)))
        .catchError((_) => controller.add(HingeStatus.none));

    return controller.stream;
  }

  static HingeStatus _decode(Object? raw) => switch (raw) {
    1 => HingeStatus.closed,
    2 => HingeStatus.partiallyOpen,
    3 => HingeStatus.fullyOpen,
    _ => HingeStatus.none,
  };
}
