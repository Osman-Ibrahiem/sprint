import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/app.dart';

void main() {
  group('App launch', () {
    testWidgets('boots in Arabic RTL without crash', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      await tester.pumpAndSettle();

      final directionality = tester.widget<Directionality>(
        find.byType(Directionality).first,
      );
      expect(directionality.textDirection, equals(TextDirection.rtl));

      expect(find.byType(ErrorWidget), findsNothing);
    });

    testWidgets('has Localizations widget with Arabic locale', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      await tester.pumpAndSettle();

      final localizations = tester.widget<Localizations>(
        find.byType(Localizations).first,
      );
      expect(localizations.locale, equals(const Locale('ar')));
    });

    testWidgets('initial route renders home screen without error', (
      tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsWidgets);
      expect(find.byType(ErrorWidget), findsNothing);
    });
  });
}
