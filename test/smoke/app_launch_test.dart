import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint/app.dart';
import 'package:sprint/core/providers/shared_preferences_provider.dart';

void main() {
  group('App launch', () {
    testWidgets('boots in Arabic RTL without crash', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const App(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 2000));

      final directionality = tester.widget<Directionality>(
        find.byType(Directionality).first,
      );
      expect(directionality.textDirection, equals(TextDirection.rtl));
      expect(find.byType(ErrorWidget), findsNothing);
    });

    testWidgets('has Localizations widget with Arabic locale', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const App(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 2000));

      final localizations = tester.widget<Localizations>(
        find.byType(Localizations).first,
      );
      expect(localizations.locale, equals(const Locale('ar')));
    });

    testWidgets('initial route renders splash screen without error', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const App(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 2000));

      expect(find.byType(Scaffold), findsWidgets);
      expect(find.byType(ErrorWidget), findsNothing);
    });
  });
}
