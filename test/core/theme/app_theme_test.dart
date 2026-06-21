import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_theme.dart';

void main() {
  group('AppColors', () {
    test('lime token is correct value', () {
      expect(AppColors.lime, equals(const Color(0xFFCCF42B)));
    });

    test('sprintGreen token is correct value', () {
      expect(AppColors.sprintGreen, equals(const Color(0xFF1B5E3B)));
    });

    test('bgBase token is correct value', () {
      expect(AppColors.bgBase, equals(const Color(0xFF0D1B13)));
    });

    test('error token is correct value', () {
      expect(AppColors.error, equals(const Color(0xFFE24B4A)));
    });
  });

  group('AppTheme', () {
    test('dark() returns valid ThemeData with M3 and Cairo', () {
      final theme = AppTheme.dark();

      expect(theme, isA<ThemeData>());
      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme.primary, equals(AppColors.sprintGreen));
      expect(theme.colorScheme.secondary, equals(AppColors.lime));
      expect(theme.textTheme.bodyLarge?.fontFamily, equals('Cairo'));
    });

    test('dark() scaffold background is bgBase', () {
      expect(AppTheme.dark().scaffoldBackgroundColor, equals(AppColors.bgBase));
    });

    test('dark() brightness is dark', () {
      expect(AppTheme.dark().brightness, equals(Brightness.dark));
    });
  });
}
