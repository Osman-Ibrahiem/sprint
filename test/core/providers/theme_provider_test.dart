import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint/core/providers/shared_preferences_provider.dart';
import 'package:sprint/core/providers/theme_provider.dart';

void main() {
  group('ThemeModeNotifier', () {
    test('build() with no saved key returns ThemeMode.dark', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(themeModeNotifierProvider), ThemeMode.dark);
    });

    test('build() with saved "light" returns ThemeMode.light', () async {
      SharedPreferences.setMockInitialValues({'sprint_theme_mode': 'light'});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(themeModeNotifierProvider), ThemeMode.light);
    });

    test('setTheme(ThemeMode.light) updates state and persists', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(container.dispose);

      container.read(themeModeNotifierProvider.notifier).setTheme(ThemeMode.light);
      expect(container.read(themeModeNotifierProvider), ThemeMode.light);

      expect(prefs.getString('sprint_theme_mode'), 'light');
    });

    test('setTheme(ThemeMode.system) is a no-op', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(container.dispose);

      container.read(themeModeNotifierProvider.notifier).setTheme(ThemeMode.system);
      expect(container.read(themeModeNotifierProvider), ThemeMode.dark);
    });
  });
}
