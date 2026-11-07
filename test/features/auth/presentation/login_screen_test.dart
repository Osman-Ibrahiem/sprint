import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/presentation/widgets/bolt_mark.dart';
import 'package:sprint/core/theme/app_theme.dart';
import 'package:sprint/features/auth/presentation/notifiers/login_form_notifier.dart';
import 'package:sprint/features/auth/presentation/screens/login_screen.dart';
import 'package:sprint/features/auth/presentation/widgets/login_brand_header.dart';
import 'package:sprint/features/auth/presentation/widgets/login_brand_pane.dart';
import 'package:sprint/features/auth/presentation/widgets/login_form.dart';
import 'package:sprint/features/auth/presentation/widgets/login_heading.dart';
import 'package:sprint/features/auth/presentation/widgets/login_identifier_field.dart';

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

      expect(find.byType(BoltMark), findsOneWidget);
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

      expect(find.text('يرجى إدخال الإيميل أو رقم الموبايل'), findsNothing);
      expect(find.text('يرجى إدخال كلمة السر'), findsNothing);
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

      expect(find.text('يرجى إدخال الإيميل أو رقم الموبايل'), findsOneWidget);
      expect(find.text('يرجى إدخال كلمة السر'), findsOneWidget);

      // Login button still present during error
      expect(find.byType(FilledButton), findsOneWidget);

      // Typing in identifier clears only its error
      await tester.enterText(find.byType(TextField).first, 'test@email.com');
      await tester.pump();

      expect(find.text('يرجى إدخال الإيميل أو رقم الموبايل'), findsNothing);
      expect(find.text('يرجى إدخال كلمة السر'), findsOneWidget);
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

  group('LoginScreen adaptive layout', () {
    Future<void> pumpAt(
      WidgetTester tester,
      Size size, {
      double keyboard = 0,
      List<DisplayFeature> features = const [],
    }) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      tester.view.viewInsets = FakeViewPadding(bottom: keyboard);
      tester.view.displayFeatures = features;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(_buildTestApp());
      await tester.pumpAndSettle();
    }

    testWidgets('360x800 is a single pane with the brand header', (
      tester,
    ) async {
      await pumpAt(tester, const Size(360, 800));
      expect(find.byType(LoginBrandPane), findsNothing);
      expect(find.byType(LoginHeading), findsNothing);
      expect(find.byType(LoginBrandHeader), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
    });

    testWidgets('form column is capped at 480 on a medium window', (
      tester,
    ) async {
      await pumpAt(tester, const Size(800, 1000));
      expect(find.byType(LoginBrandPane), findsNothing);
      final w = tester.getSize(find.byType(LoginIdentifierField)).width;
      expect(w, 480);
    });

    testWidgets('1280x800 is two panes, brand pane on the start (right) side', (
      tester,
    ) async {
      await pumpAt(tester, const Size(1280, 800));
      expect(find.byType(LoginBrandPane), findsOneWidget);
      expect(find.byType(LoginHeading), findsOneWidget);
      expect(find.byType(LoginBrandHeader), findsNothing);
      expect(find.text('ابدأ حجزك دلوقتي'), findsOneWidget);
      final brandX = tester.getCenter(find.byType(LoginBrandPane)).dx;
      final formX = tester.getCenter(find.byType(LoginForm)).dx;
      expect(brandX, greaterThan(formX));
      // 480 form + 2 * 48 (Large margin) = 576 form pane.
      expect(tester.getSize(find.byType(LoginBrandPane)).width, 1280 - 576);
      expect(tester.getSize(find.byType(LoginIdentifierField)).width, 480);
    });

    testWidgets('840 wide keeps the brand pane at its 360 minimum', (
      tester,
    ) async {
      await pumpAt(tester, const Size(840, 800));
      expect(tester.getSize(find.byType(LoginBrandPane)).width, 360);
    });

    testWidgets('keyboard open: button stays reachable by scrolling', (
      tester,
    ) async {
      await pumpAt(tester, const Size(360, 700), keyboard: 300);
      await tester.tap(find.byType(TextField).last);
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byType(FilledButton));
      await tester.pumpAndSettle();
      final bottom = tester.getBottomLeft(find.byType(FilledButton)).dy;
      expect(bottom, lessThanOrEqualTo(700 - 300));
      expect(tester.takeException(), isNull);
    });

    testWidgets('flex posture: header above hinge, form below', (tester) async {
      await pumpAt(
        tester,
        const Size(412, 900),
        features: const [
          DisplayFeature(
            bounds: Rect.fromLTWH(0, 440, 412, 20),
            type: DisplayFeatureType.hinge,
            state: DisplayFeatureState.postureHalfOpened,
          ),
        ],
      );
      final header = tester.getBottomLeft(find.byType(LoginBrandHeader)).dy;
      final form = tester.getTopLeft(find.byType(LoginForm)).dy;
      expect(header, lessThanOrEqualTo(440));
      expect(form, greaterThanOrEqualTo(460));
    });

    testWidgets('flat hinge is ignored', (tester) async {
      await pumpAt(
        tester,
        const Size(412, 900),
        features: const [
          DisplayFeature(
            bounds: Rect.fromLTWH(0, 440, 412, 20),
            type: DisplayFeatureType.hinge,
            state: DisplayFeatureState.postureFlat,
          ),
        ],
      );
      final header = tester.getTopLeft(find.byType(LoginBrandHeader)).dy;
      final form = tester.getTopLeft(find.byType(LoginForm)).dy;
      expect(form - header, lessThan(300));
    });
  });
}
