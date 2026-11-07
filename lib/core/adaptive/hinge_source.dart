/// State of a device hinge as reported by the operating system.
enum HingeStatus {
  /// No hinge, or the OS does not report one.
  none,

  /// Folded shut: the app is on the cover screen.
  closed,

  /// Between closed and fully open (book / Flex posture).
  partiallyOpen,

  /// Open as far as the device allows.
  fullyOpen;

  /// The inner (large) screen is in use and split by the hinge.
  bool get splitsScreen => this == partiallyOpen || this == fullyOpen;
}

/// Where hinge state comes from. Platform channels stay behind this
/// interface; presentation reads it through a provider only.
abstract interface class HingeSource {
  /// Current state followed by every change.
  Stream<HingeStatus> watch();
}

/// Source for platforms that report hinges through the Flutter engine itself
/// (Android, Windows) or have none: it never emits a hinge.
class NoHingeSource implements HingeSource {
  const NoHingeSource();

  @override
  Stream<HingeStatus> watch() => Stream.value(HingeStatus.none);
}
