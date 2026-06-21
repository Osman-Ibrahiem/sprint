import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprint/core/providers/shared_preferences_provider.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final saved = prefs.getString('sprint_locale');
    return Locale(saved ?? 'ar');
  }

  void setLocale(Locale locale) {
    if (!['ar', 'en'].contains(locale.languageCode)) {
      assert(false, 'Unsupported locale: ${locale.languageCode}');
      return;
    }
    state = locale;
    ref.read(sharedPreferencesProvider).setString('sprint_locale', locale.languageCode);
  }
}
