import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint/core/providers/locale_provider.dart';
import 'package:sprint/core/providers/shared_preferences_provider.dart';

void main() {
  group('LocaleNotifier', () {
    test('build() with no saved key returns Locale("ar")', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(localeNotifierProvider), const Locale('ar'));
    });

    test('build() with saved "en" returns Locale("en")', () async {
      SharedPreferences.setMockInitialValues({'sprint_locale': 'en'});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(localeNotifierProvider), const Locale('en'));
    });

    test('setLocale(Locale("en")) updates state and persists', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(container.dispose);

      container.read(localeNotifierProvider.notifier).setLocale(const Locale('en'));
      expect(container.read(localeNotifierProvider), const Locale('en'));

      expect(prefs.getString('sprint_locale'), 'en');
    });

    test('setLocale(Locale("fr")) is a no-op', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(container.dispose);

      expect(
        () => container.read(localeNotifierProvider.notifier).setLocale(const Locale('fr')),
        throwsA(isA<AssertionError>()),
      );
      expect(container.read(localeNotifierProvider), const Locale('ar'));
    });
  });
}
