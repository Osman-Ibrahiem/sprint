import 'package:flutter/material.dart';

/// Sprint corner-radius tokens.
/// Source: Sprint Brand Guidelines v1.0 via Claude Design export.
abstract final class AppRadius {
  /// Small chips / inner elements: 8px
  static const double sm = 8.0;

  /// Buttons & form fields: 12px
  static const double md = 12.0;

  /// Large cards: 16px
  static const double lg = 16.0;

  /// Sheets / modals: 20px
  static const double xl = 20.0;

  /// Badges, pills, avatars — fully round: 999px
  static const double pill = 999.0;

  // BorderRadius helpers
  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlAll = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius pillAll = BorderRadius.all(Radius.circular(pill));
}
