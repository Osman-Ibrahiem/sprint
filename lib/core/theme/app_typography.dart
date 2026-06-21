import 'package:flutter/material.dart';

/// Sprint typography — single typeface: Cairo.
/// Weights supplied: 200·300·400·600·700·900.
/// 500 (Medium) falls back to 400 (Regular); 800 (ExtraBold) falls back to 900 (Black).
/// Source: Sprint Brand Guidelines v1.0 via Claude Design export.
abstract final class AppTypography {
  static const String _family = 'Cairo';

  // ── Font-weight constants ────────────────────────────────────────────────
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500; // falls back to w400
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800; // falls back to w900
  static const FontWeight black = FontWeight.w900;

  // ── Type-scale helpers ───────────────────────────────────────────────────
  static TextStyle _s(
    double size,
    FontWeight weight, {
    double height = 1.55,
    Color? color,
  }) => TextStyle(
    fontFamily: _family,
    fontSize: size,
    fontWeight: weight,
    height: height,
    color: color,
  );

  // ── Named scale (mirrors CSS tokens) ────────────────────────────────────
  /// 40px · Black — splash / hero display
  static TextStyle get display => _s(40, black, height: 1.15);

  /// 32px · ExtraBold — large heading (h1)
  static TextStyle get h1 => _s(32, extraBold, height: 1.15);

  /// 26px · Bold — section heading (h2)
  static TextStyle get h2 => _s(26, bold, height: 1.3);

  /// 20px · SemiBold — subsection (h3)
  static TextStyle get h3 => _s(20, semiBold, height: 1.3);

  /// 16px · Medium — lead body copy
  static TextStyle get bodyLg => _s(16, medium, height: 1.55);

  /// 15px · Medium — default body
  static TextStyle get body => _s(15, medium, height: 1.55);

  /// 14px · Regular — small / caption
  static TextStyle get sm => _s(14, regular, height: 1.55);

  /// 12px · Regular — fine print
  static TextStyle get xs => _s(12, regular, height: 1.7);

  /// 11px · SemiBold — badges / micro labels
  static TextStyle get micro => _s(11, semiBold, height: 1.3);

  // ── Material 3 TextTheme ─────────────────────────────────────────────────
  /// Full M3 TextTheme mapped to the Sprint type scale.
  static TextTheme get textTheme => const TextTheme(
    // Display
    displayLarge: TextStyle(
      fontFamily: _family,
      fontSize: 40,
      fontWeight: FontWeight.w900,
      height: 1.15,
    ),
    displayMedium: TextStyle(
      fontFamily: _family,
      fontSize: 32,
      fontWeight: FontWeight.w800,
      height: 1.15,
    ),
    displaySmall: TextStyle(
      fontFamily: _family,
      fontSize: 26,
      fontWeight: FontWeight.w700,
      height: 1.3,
    ),
    // Headline
    headlineLarge: TextStyle(
      fontFamily: _family,
      fontSize: 26,
      fontWeight: FontWeight.w700,
      height: 1.3,
    ),
    headlineMedium: TextStyle(
      fontFamily: _family,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    headlineSmall: TextStyle(
      fontFamily: _family,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    // Title
    titleLarge: TextStyle(
      fontFamily: _family,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    titleMedium: TextStyle(
      fontFamily: _family,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.55,
    ),
    titleSmall: TextStyle(
      fontFamily: _family,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.55,
    ),
    // Body
    bodyLarge: TextStyle(
      fontFamily: _family,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.55,
    ),
    bodyMedium: TextStyle(
      fontFamily: _family,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      height: 1.55,
    ),
    bodySmall: TextStyle(
      fontFamily: _family,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.55,
    ),
    // Label
    labelLarge: TextStyle(
      fontFamily: _family,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    labelMedium: TextStyle(
      fontFamily: _family,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.7,
    ),
    labelSmall: TextStyle(
      fontFamily: _family,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
  );
}
