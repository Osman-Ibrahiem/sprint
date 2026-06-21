import 'package:flutter/material.dart';

/// Sprint design-system color tokens.
/// Source: Sprint Brand Guidelines v1.0 via Claude Design export.
/// Dark mode is the app default. All semantic aliases reflect dark-mode values.
abstract final class AppColors {
  // ── Brand core ──────────────────────────────────────────────────────────
  static const Color sprintGreen = Color(0xFF1B5E3B); // logo bg / primary btn
  static const Color sprintGreenDeep = Color(0xFF0F4C2F); // pressed / darker
  static const Color lime = Color(0xFFCCF42B); // accent / CTA
  static const Color limeSoft = Color(0xFFDFF96B); // lime hover

  // ── Green ramp (neutrals live on a green axis) ───────────────────────────
  static const Color green900 = Color(0xFF0D1B13); // dark page base
  static const Color green800 = Color(0xFF122B1D); // dark surface / cards
  static const Color green700 = Color(0xFF1A3D2A); // dark elevated
  static const Color green600 = Color(0xFF2E5E3E); // dark border
  static const Color green500 = Color(0xFF5EA87A); // secondary text / icons
  static const Color green300 = Color(0xFFA8D8BA); // light borders / dividers
  static const Color green100 = Color(0xFFD0E8D8); // light-mode border
  static const Color green75  = Color(0xFFE8F3EC); // light-mode outline variant
  static const Color green50  = Color(0xFFF8FFF9); // lightest / light page base

  // ── True neutrals ────────────────────────────────────────────────────────
  static const Color ink900 = Color(0xFF1A1A1A); // text-primary on light
  static const Color ink500 = Color(0xFF666666); // text-secondary on light
  static const Color white = Color(0xFFFFFFFF);

  // ── Semantic hues ────────────────────────────────────────────────────────
  static const Color success = Color(0xFF1D9E75);
  static const Color warning = Color(0xFFEF9F27);
  static const Color error = Color(0xFFE24B4A);
  static const Color errorContainer = Color(0xFF4A1515);
  static const Color onErrorContainer = Color(0xFFFFB4A9);
  static const Color info = Color(0xFF378ADD);

  // ── Status badge pairs ───────────────────────────────────────────────────
  static const Color badgeConfirmedBg = Color(0xFFE4F7EC);
  static const Color badgeConfirmedFg = Color(0xFF0F6E56);
  static const Color badgePendingBg = Color(0xFFFFF9E6);
  static const Color badgePendingFg = Color(0xFF854F0B);
  static const Color badgeCancelledBg = Color(0xFFFCEBEB);
  static const Color badgeCancelledFg = Color(0xFFA32D2D);
  static const Color badgeTrainerBg = Color(0xFFE6F1FB);
  static const Color badgeTrainerFg = Color(0xFF185FA5);
  static const Color badgeFeaturedBg = Color(0xFFF4FFB0);
  static const Color badgeFeaturedFg = Color(0xFF3B6D11);

  // ── Dark-mode semantic aliases (app default) ─────────────────────────────
  static const Color bgBase = green900; // #0D1B13
  static const Color bgSurface = green800; // #122B1D
  static const Color bgElevated = green700; // #1A3D2A
  static const Color border = green600; // #2E5E3E
  static const Color borderSubtle = Color(0xFF163525);
  static const Color textPrimary = green50; // #F8FFF9
  static const Color textSecondary = green500; // #5EA87A
  static const Color textMuted = Color(0xFF3E6E50);
  static const Color accent = lime; // #CCF42B
  static const Color onAccent = sprintGreen; // text/icon on lime fill
  static const Color onPrimary = lime; // text on green primary button
  static const Color overlay = Color(0xA80D1B13); // rgba(13,27,19,0.66)
  static const Color focusRing = Color(0x8DCCF42B); // rgba(204,244,43,0.55)
}
