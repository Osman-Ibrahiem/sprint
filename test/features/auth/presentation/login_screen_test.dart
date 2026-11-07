import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_theme.dart';
import 'package:sprint/features/auth/presentation/notifiers/login_form_notifier.dart';
import 'package:sprint/features/auth/presentation/screens/login_screen.dart';

Widget _wrapInApp(Widget child) => MaterialApp(
  theme: AppTheme.dark(),
  locale: const Locale('ar'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

Widget _buildTestApp() => ProviderScope(child: _wrapInApp(const LoginScreen()));

void main() {
  group('LoginScreen default state (US1)', () {
    testWidgets('renders bolt icon, app name, and login title', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.bolt_rounded), findsOneWidget);
      expect(find.text('سبرنت'), findsOneWidget);
      expect(find.text('أهلاً بيك في سبرنت'), findsOneWidget);
    });

    testWidgets('renders identifier and password fields with correct hints', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      final fields = find.byType(TextField);
      expect(fields, findsNWidgets(2));

      final idDecoration = tester.widget<TextField>(fields.first).decoration;
      expect(idDecoration?.hintText, 'الإيميل أو رقم الموبايل');

      final pwDecoration = tester.widget<TextField>(fields.last).decoration;
      expect(pwDecoration?.hintText, 'كلمة السر');
    });

    testWidgets('renders login button with no errors or spinner', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('دخول'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      final idField = tester.widget<TextField>(find.byType(TextField).first);
      expect(idField.decoration?.errorText, isNull);

      final pwField = tester.widget<TextField>(find.byType(TextField).last);
      expect(pwField.decoration?.errorText, isNull);
    });
  });

  group('LoginScreen focus and visibility (US2)', () {
    testWidgets('identifier field gains focus on tap', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextField).first);
      await tester.pump();

      expect(FocusManager.instance.primaryFocus, isNotNull);
      expect(FocusManager.instance.primaryFocus!.hasFocus, isTrue);
    });

    testWidgets('password field gains focus on tap', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextField).last);
      await tester.pump();

      expect(FocusManager.instance.primaryFocus, isNotNull);
      expect(FocusManager.instance.primaryFocus!.hasFocus, isTrue);
    });

    testWidgets('password visibility toggles on eye icon tap', (tester) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      expect(
        tester.widget<TextField>(find.byType(TextField).last).obscureText,
        isTrue,
      );

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(
        tester.widget<TextField>(find.byType(TextField).last).obscureText,
        isFalse,
      );

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(
        tester.widget<TextField>(find.byType(TextField).last).obscureText,
        isTrue,
      );
    });
  });

  group('LoginScreen error state (US3)', () {
    testWidgets('shows error text on both fields and clears independently', (
      tester,
    ) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: _wrapInApp(const LoginScreen()),
        ),
      );
      await tester.pumpAndSettle();

      container.read(loginFormProvider.notifier).mockSetError();
      await tester.pump();

      expect(
        tester
            .widget<TextField>(find.byType(TextField).first)
            .decoration
            ?.errorText,
        isNotNull,
      );
      expect(
        tester
            .widget<TextField>(find.byType(TextField).last)
            .decoration
            ?.errorText,
        isNotNull,
      );

      // Login button still present during error
      expect(find.byType(FilledButton), findsOneWidget);

      // Typing in identifier clears only its error
      await tester.enterText(find.byType(TextField).first, 'test@email.com');
      await tester.pump();

      expect(
        tester
            .widget<TextField>(find.byType(TextField).first)
            .decoration
            ?.errorText,
        isNull,
      );
      expect(
        tester
            .widget<TextField>(find.byType(TextField).last)
            .decoration
            ?.errorText,
        isNotNull,
      );
    });
  });

  group('LoginScreen loading state (US4)', () {
    testWidgets('shows spinner on login tap and reverts after 1800ms', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('دخول'), findsNothing);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );

      // Advance past the 1800ms mock delay
      await tester.pump(const Duration(milliseconds: 1900));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('دخول'), findsOneWidget);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNotNull,
      );
    });
  });
}
