import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';
import 'package:sprint/core/theme/app_typography.dart';

/// Single factory for the Sprint ThemeData.
/// Usage: `MaterialApp(theme: AppTheme.dark(), ...)`
abstract final class AppTheme {
  static ThemeData light() {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.sprintGreen,
      onPrimary: AppColors.lime,
      primaryContainer: AppColors.sprintGreenDeep,
      onPrimaryContainer: AppColors.lime,
      secondary: AppColors.lime,
      onSecondary: AppColors.sprintGreen,
      secondaryContainer: AppColors.green100,
      onSecondaryContainer: AppColors.green900,
      tertiary: AppColors.green500,
      onTertiary: AppColors.green900,
      tertiaryContainer: AppColors.green700,
      onTertiaryContainer: AppColors.green300,
      error: AppColors.error,
      onError: AppColors.white,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.white,
      onSurface: AppColors.ink900,
      surfaceContainerHighest: AppColors.green100,
      onSurfaceVariant: AppColors.ink500,
      outline: AppColors.green100,
      outlineVariant: Color(0xFFE8F3EC),
      inverseSurface: AppColors.ink900,
      onInverseSurface: AppColors.green50,
      inversePrimary: AppColors.sprintGreen,
      scrim: AppColors.overlay,
      shadow: AppColors.ink900,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.green50,
      fontFamily: 'Cairo',
      textTheme: AppTypography.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.green50,
        foregroundColor: AppColors.ink900,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppTypography.h3.copyWith(color: AppColors.ink900),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side: BorderSide(color: AppColors.green100),
        ),
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.sprintGreen,
          foregroundColor: AppColors.lime,
          disabledBackgroundColor: AppColors.sprintGreen.withAlpha(102),
          disabledForegroundColor: AppColors.lime.withAlpha(102),
          textStyle: AppTypography.bodyLg.copyWith(
            fontWeight: AppTypography.bold,
          ),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          minimumSize: const Size(double.infinity, 52),
          elevation: 0,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.lime,
          foregroundColor: AppColors.sprintGreen,
          disabledBackgroundColor: AppColors.lime.withAlpha(102),
          textStyle: AppTypography.bodyLg.copyWith(
            fontWeight: AppTypography.extraBold,
          ),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          minimumSize: const Size(double.infinity, 52),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.sprintGreen,
          side: const BorderSide(color: AppColors.sprintGreen),
          textStyle: AppTypography.bodyLg.copyWith(
            fontWeight: AppTypography.bold,
          ),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          minimumSize: const Size(double.infinity, 52),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.ink500,
          textStyle: AppTypography.body,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.green100),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.green100),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.lime, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.error),
        ),
        hintStyle: AppTypography.body.copyWith(color: AppColors.ink500),
        labelStyle: AppTypography.sm.copyWith(color: AppColors.ink500),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.lime,
        unselectedItemColor: AppColors.ink500,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.green50,
        selectedColor: AppColors.lime,
        labelStyle: AppTypography.sm,
        side: const BorderSide(color: AppColors.green100),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.pillAll),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.green100,
        thickness: 1,
        space: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
        elevation: 0,
      ),
    );
  }

  static ThemeData dark() {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      // ── Primary (Sprint green) ──────────────────────────────────────────
      primary: AppColors.sprintGreen,
      onPrimary: AppColors.lime,
      primaryContainer: AppColors.sprintGreenDeep,
      onPrimaryContainer: AppColors.lime,
      // ── Secondary (Lime accent / CTA) ──────────────────────────────────
      secondary: AppColors.lime,
      onSecondary: AppColors.sprintGreen,
      secondaryContainer: AppColors.green700,
      onSecondaryContainer: AppColors.green50,
      // ── Tertiary (mid-green for icons & supporting elements) ───────────
      tertiary: AppColors.green500,
      onTertiary: AppColors.green900,
      tertiaryContainer: AppColors.green700,
      onTertiaryContainer: AppColors.green300,
      // ── Error ───────────────────────────────────────────────────────────
      error: AppColors.error,
      onError: AppColors.white,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      // ── Background / surface stack ─────────────────────────────────────
      surface: AppColors.green800,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.green700,
      onSurfaceVariant: AppColors.textSecondary,
      // ── Outline ────────────────────────────────────────────────────────
      outline: AppColors.green600,
      outlineVariant: AppColors.borderSubtle,
      // ── Inverse ────────────────────────────────────────────────────────
      inverseSurface: AppColors.green50,
      onInverseSurface: AppColors.ink900,
      inversePrimary: AppColors.sprintGreen,
      // ── Scrim / shadow ─────────────────────────────────────────────────
      scrim: AppColors.overlay,
      shadow: AppColors.green900,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bgBase,
      fontFamily: 'Cairo',
      textTheme: AppTypography.textTheme,

      // ── AppBar ─────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgBase,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppTypography.h3.copyWith(color: AppColors.textPrimary),
      ),

      // ── Cards ──────────────────────────────────────────────────────────
      cardTheme: const CardThemeData(
        color: AppColors.bgSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side: BorderSide(color: AppColors.border),
        ),
        elevation: 0,
        margin: EdgeInsets.zero,
      ),

      // ── ElevatedButton (primary — green fill / lime text) ─────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.sprintGreen,
          foregroundColor: AppColors.lime,
          disabledBackgroundColor: AppColors.sprintGreen.withAlpha(102),
          disabledForegroundColor: AppColors.lime.withAlpha(102),
          textStyle: AppTypography.bodyLg.copyWith(
            fontWeight: AppTypography.bold,
          ),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          minimumSize: const Size(double.infinity, 52),
          elevation: 0,
        ),
      ),

      // ── FilledButton (accent — lime fill / green text) ─────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.lime,
          foregroundColor: AppColors.sprintGreen,
          disabledBackgroundColor: AppColors.lime.withAlpha(102),
          textStyle: AppTypography.bodyLg.copyWith(
            fontWeight: AppTypography.extraBold,
          ),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          minimumSize: const Size(double.infinity, 52),
          elevation: 0,
        ),
      ),

      // ── OutlinedButton (secondary — green outline) ──────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.sprintGreen,
          side: const BorderSide(color: AppColors.sprintGreen),
          textStyle: AppTypography.bodyLg.copyWith(
            fontWeight: AppTypography.bold,
          ),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          minimumSize: const Size(double.infinity, 52),
        ),
      ),

      // ── TextButton (ghost) ──────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          textStyle: AppTypography.body,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        ),
      ),

      // ── InputDecoration ─────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.bgSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.lime, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: AppColors.error),
        ),
        hintStyle: AppTypography.body.copyWith(color: AppColors.textMuted),
        labelStyle: AppTypography.sm.copyWith(color: AppColors.textSecondary),
      ),

      // ── Bottom navigation ───────────────────────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.bgSurface,
        selectedItemColor: AppColors.lime,
        unselectedItemColor: AppColors.textSecondary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      // ── Chips ───────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.bgElevated,
        selectedColor: AppColors.lime,
        labelStyle: AppTypography.sm,
        side: const BorderSide(color: AppColors.border),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.pillAll),
      ),

      // ── Divider ─────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 0,
      ),

      // ── BottomSheet ─────────────────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.bgSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
