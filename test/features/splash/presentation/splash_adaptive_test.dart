import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sprint/core/adaptive/adaptive_tokens.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_spinner.dart';
import 'package:sprint/core/theme/app_theme.dart';
import 'package:sprint/features/splash/presentation/screens/splash_screen.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_corner_brackets.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_icon.dart';

Widget _app(Widget home) => MaterialApp(
  theme: AppTheme.dark(),
  locale: const Locale('ar'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: home,
);

Widget _routerApp() => MaterialApp.router(
  theme: AppTheme.dark(),
  locale: const Locale('ar'),
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  routerConfig: GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, _) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, _) => const SizedBox()),
    ],
  ),
);

void main() {
  group('SplashLimits', () {
    test('tall windows keep the token size and the spinner', () {
      expect(SplashLimits.isShort(667), isFalse);
      expect(SplashLimits.logoSize(160, 667), 160);
    });

    test('short windows cap the logo at a third of the height', () {
      expect(SplashLimits.isShort(599), isTrue);
      expect(SplashLimits.logoSize(160, 420), 138);
      expect(SplashLimits.logoSize(200, 466), 153);
      // Never larger than the class token.
      expect(SplashLimits.logoSize(100, 590), 100);
    });
  });

  group('SplashCornerBrackets', () {
    Future<List<Rect>> bracketRects(
      WidgetTester tester,
      Size size,
      EdgeInsets padding,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      tester.view.padding = FakeViewPadding(
        top: padding.top,
        bottom: padding.bottom,
        left: padding.left,
        right: padding.right,
      );
      tester.view.viewPadding = tester.view.padding;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(_app(const SplashCornerBrackets()));
      final boxes = find.descendant(
        of: find.byType(SplashCornerBrackets),
        matching: find.byType(DecoratedBox),
      );
      return [for (var i = 0; i < 4; i++) tester.getRect(boxes.at(i))];
    }

    testWidgets('compact: safe area + 24 dp inset', (tester) async {
      final r = await bracketRects(
        tester,
        const Size(402, 874),
        const EdgeInsets.only(top: 62, bottom: 34),
      );
      // TL, TR, BL, BR
      expect(r[0].topLeft, const Offset(24, 86));
      expect(r[1].topRight, const Offset(402 - 24, 86));
      expect(r[2].bottomLeft, const Offset(24, 874 - 34 - 24));
      expect(r[3].bottomRight, const Offset(402 - 24, 874 - 34 - 24));
    });

    testWidgets('medium: 32 dp inset, landscape side insets respected', (
      tester,
    ) async {
      final r = await bracketRects(
        tester,
        const Size(678, 466),
        const EdgeInsets.only(left: 10),
      );
      expect(r[0].topLeft, const Offset(10 + 32, 32));
      expect(r[3].bottomRight, const Offset(678 - 32, 466 - 32));
    });
  });

  group('SplashScreen adaptive sizing', () {
    Future<void> pumpSplash(WidgetTester tester, Size size) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(_routerApp());
      // precacheImage decodes on real async time, outside fake-async.
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 300)),
      );
      // Native-splash hold (500 ms) + the 2.8 s transition.
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump(const Duration(milliseconds: 2000));
    }

    double logoSize(WidgetTester tester) =>
        tester.getSize(find.byType(SplashIcon)).width;

    testWidgets('360x800: 160 dp logo and a spinner', (tester) async {
      await pumpSplash(tester, const Size(360, 800));
      expect(logoSize(tester), 160);
      expect(find.byType(AdaptiveSpinner), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('1280x720: 240 dp logo and a spinner', (tester) async {
      await pumpSplash(tester, const Size(1280, 720));
      expect(logoSize(tester), 240);
      expect(find.byType(AdaptiveSpinner), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('380x420: shrunk logo and no spinner', (tester) async {
      await pumpSplash(tester, const Size(380, 420));
      expect(logoSize(tester), 138);
      expect(find.byType(AdaptiveSpinner), findsNothing);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });
}
