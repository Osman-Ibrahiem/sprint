/// Sprint spacing scale — strict 4px grid.
/// Source: Sprint Brand Guidelines v1.0 via Claude Design export.
/// Scale: 2xs·2 | xs·4 | sm·8 | md·12 | lg·16 | xl·24 | 2xl·32 | 3xl·48 | 4xl·64
abstract final class AppSpacing {
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 48.0;
  static const double xxxxl = 64.0;

  /// Default horizontal screen padding.
  static const double screenPad = xl; // 24

  /// Gap between major page sections.
  static const double sectionGap = xxl; // 32

  /// Default horizontal content gutter inside cards/containers.
  static const double gutter = lg; // 16
}
