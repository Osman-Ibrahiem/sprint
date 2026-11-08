import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_tokens.dart';
import 'package:sprint/core/adaptive/size_class.dart';
import 'package:sprint/core/theme/app_typography.dart';

/// Size-class-aware text styles. Weight, height and family come from
/// [AppTypography] (Compact values); only the size follows the class.
class AdaptiveTypography {
  const AdaptiveTypography._(this._t);

  factory AdaptiveTypography.of(SizeClass sizeClass) =>
      AdaptiveTypography._(AdaptiveTokens.of(sizeClass).type);

  final TypeScaleTokens _t;

  TextStyle get displayXl =>
      AppTypography.displayXl.copyWith(fontSize: _t.displayXl);
  TextStyle get display => AppTypography.display.copyWith(fontSize: _t.display);
  TextStyle get h1 => AppTypography.h1.copyWith(fontSize: _t.h1);
  TextStyle get h2 => AppTypography.h2.copyWith(fontSize: _t.h2);
  TextStyle get h3 => AppTypography.h3.copyWith(fontSize: _t.h3);
  TextStyle get bodyLg => AppTypography.bodyLg.copyWith(fontSize: _t.bodyLg);
  TextStyle get body => AppTypography.body.copyWith(fontSize: _t.body);
  TextStyle get sm => AppTypography.sm.copyWith(fontSize: _t.sm);
  TextStyle get xs => AppTypography.xs.copyWith(fontSize: _t.xs);
  TextStyle get micro => AppTypography.micro.copyWith(fontSize: _t.micro);
}
