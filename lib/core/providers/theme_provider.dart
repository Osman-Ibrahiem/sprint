import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprint/core/providers/shared_preferences_provider.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final saved = prefs.getString('sprint_theme_mode');
    return ThemeMode.values.byName(saved ?? 'dark');
  }

  void setTheme(ThemeMode mode) {
    if (mode == ThemeMode.system) return;
    state = mode;
    ref.read(sharedPreferencesProvider).setString('sprint_theme_mode', mode.name);
  }
}
