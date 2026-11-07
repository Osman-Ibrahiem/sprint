import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/adaptive/hinge_override.dart';
import 'package:sprint/core/adaptive/hinge_source.dart';
import 'package:sprint/core/adaptive/ios_hinge_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel(IosHingeSource.channelName);

  void mockStatus(int? value) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          if (call.method == 'getStatus') return value;
          return null;
        });
  }

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('initial status is read from the native side', () async {
    mockStatus(3);
    expect(await IosHingeSource().watch().first, HingeStatus.fullyOpen);
    mockStatus(2);
    expect(await IosHingeSource().watch().first, HingeStatus.partiallyOpen);
    mockStatus(1);
    expect(await IosHingeSource().watch().first, HingeStatus.closed);
  });

  test('a device without a hinge reports none', () async {
    mockStatus(0);
    expect(await IosHingeSource().watch().first, HingeStatus.none);
    mockStatus(null);
    expect(await IosHingeSource().watch().first, HingeStatus.none);
  });

  test('later native updates are streamed', () async {
    mockStatus(1);
    final events = <HingeStatus>[];
    final sub = IosHingeSource().watch().listen(events.add);
    await Future<void>.delayed(Duration.zero);
    await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
          IosHingeSource.channelName,
          const StandardMethodCodec().encodeMethodCall(
            const MethodCall('status', 3),
          ),
          (_) {},
        );
    await Future<void>.delayed(Duration.zero);
    await sub.cancel();
    expect(events, [HingeStatus.closed, HingeStatus.fullyOpen]);
  });

  test('only open states split the screen', () {
    expect(HingeStatus.none.splitsScreen, isFalse);
    expect(HingeStatus.closed.splitsScreen, isFalse);
    expect(HingeStatus.partiallyOpen.splitsScreen, isTrue);
    expect(HingeStatus.fullyOpen.splitsScreen, isTrue);
  });

  test('hinge splits the long side', () {
    expect(HingeOverride.modeFor(const Size(890, 626)), 'vertical');
    expect(HingeOverride.modeFor(const Size(626, 890)), 'horizontal');
  });
}
