import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/adaptive/app_icons.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_filled_button.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_spinner.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_text_field.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_theme.dart';

Widget _app(TargetPlatform platform, Widget child) => MaterialApp(
  theme: AppTheme.dark().copyWith(platform: platform),
  home: Scaffold(
    body: Directionality(
      textDirection: TextDirection.rtl,
      child: Center(child: SizedBox(width: 312, child: child)),
    ),
  ),
);

ShapeDecoration _boxDecoration(WidgetTester tester) {
  final box = tester.widget<Container>(
    find.descendant(
      of: find.byType(AdaptiveTextField),
      matching: find.byType(Container),
    ),
  );
  return box.decoration! as ShapeDecoration;
}

void main() {
  group('AdaptiveTextField', () {
    testWidgets('Apple: 50 dp squircle, no resting border', (tester) async {
      await tester.pumpWidget(
        _app(TargetPlatform.iOS, const AdaptiveTextField(hintText: 'h')),
      );
      expect(tester.getSize(find.byType(AdaptiveTextField)).height, 50);
      final d = _boxDecoration(tester);
      expect(d.shape, isA<RoundedSuperellipseBorder>());
      expect(
        (d.shape as RoundedSuperellipseBorder).side.color,
        Colors.transparent,
      );
      expect(d.color, AppColors.bgSurface);
    });

    testWidgets('Material: 56 dp, 1 dp border at rest', (tester) async {
      await tester.pumpWidget(
        _app(TargetPlatform.android, const AdaptiveTextField(hintText: 'h')),
      );
      expect(tester.getSize(find.byType(AdaptiveTextField)).height, 56);
      final shape = _boxDecoration(tester).shape as RoundedRectangleBorder;
      expect(shape.side.color, AppColors.border);
      expect(shape.side.width, 1);
    });

    testWidgets('focus: Material 2 dp lime', (tester) async {
      await tester.pumpWidget(
        _app(TargetPlatform.android, const AdaptiveTextField(hintText: 'h')),
      );
      await tester.tap(find.byType(TextField));
      await tester.pump();
      final shape = _boxDecoration(tester).shape as RoundedRectangleBorder;
      expect(shape.side.color, AppColors.accent);
      expect(shape.side.width, 2);
    });

    testWidgets('focus: Apple 1 dp lime + elevated fill', (tester) async {
      await tester.pumpWidget(
        _app(TargetPlatform.iOS, const AdaptiveTextField(hintText: 'h')),
      );
      await tester.tap(find.byType(TextField));
      await tester.pump();
      final d = _boxDecoration(tester);
      final side = (d.shape as RoundedSuperellipseBorder).side;
      expect(side.color, AppColors.accent);
      expect(side.width, 1);
      expect(d.color, AppColors.bgElevated);
    });

    for (final p in [TargetPlatform.iOS, TargetPlatform.android]) {
      testWidgets('error shows caption and error border ($p)', (tester) async {
        await tester.pumpWidget(
          _app(p, const AdaptiveTextField(hintText: 'h', errorText: 'bad')),
        );
        expect(find.text('bad'), findsOneWidget);
        final side = (_boxDecoration(tester).shape as OutlinedBorder).side;
        expect(side.color, AppColors.error);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('obscures text and reports changes', (tester) async {
      String? changed;
      await tester.pumpWidget(
        _app(
          TargetPlatform.android,
          AdaptiveTextField(
            hintText: 'h',
            obscureText: true,
            onChanged: (v) => changed = v,
          ),
        ),
      );
      expect(
        tester.widget<TextField>(find.byType(TextField)).obscureText,
        isTrue,
      );
      await tester.enterText(find.byType(TextField), 'abc');
      expect(changed, 'abc');
    });

    testWidgets('leading and trailing render', (tester) async {
      await tester.pumpWidget(
        _app(
          TargetPlatform.android,
          const AdaptiveTextField(
            hintText: 'h',
            leading: Icons.lock_outline_rounded,
            trailing: Icon(Icons.visibility_outlined),
          ),
        ),
      );
      expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });
  });

  group('AdaptiveFilledButton', () {
    testWidgets('Apple: capsule 50 dp', (tester) async {
      await tester.pumpWidget(
        _app(
          TargetPlatform.iOS,
          AdaptiveFilledButton(label: 'go', onPressed: () {}),
        ),
      );
      expect(tester.getSize(find.byType(FilledButton)).height, 50);
      final btn = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(btn.style!.shape!.resolve({}), isA<StadiumBorder>());
    });

    testWidgets('Material: 12 dp radius 52 dp', (tester) async {
      await tester.pumpWidget(
        _app(
          TargetPlatform.android,
          AdaptiveFilledButton(label: 'go', onPressed: () {}),
        ),
      );
      expect(tester.getSize(find.byType(FilledButton)).height, 52);
      final btn = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(btn.style!.shape!.resolve({}), isA<RoundedRectangleBorder>());
    });

    testWidgets('loading swaps label for spinner, ignores taps, keeps size', (
      tester,
    ) async {
      var taps = 0;
      Widget build(bool loading) => _app(
        TargetPlatform.android,
        AdaptiveFilledButton(
          label: 'go',
          isLoading: loading,
          onPressed: () => taps++,
        ),
      );
      await tester.pumpWidget(build(false));
      final before = tester.getSize(find.byType(FilledButton));
      expect(find.text('go'), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      expect(taps, 1);

      await tester.pumpWidget(build(true));
      expect(find.text('go'), findsNothing);
      expect(find.byType(AdaptiveSpinner), findsOneWidget);
      expect(tester.getSize(find.byType(FilledButton)), before);
      await tester.tap(find.byType(FilledButton), warnIfMissed: false);
      expect(taps, 1);
    });
  });

  group('AdaptiveSpinner', () {
    testWidgets('Apple uses CupertinoActivityIndicator', (tester) async {
      await tester.pumpWidget(
        _app(
          TargetPlatform.iOS,
          const Center(child: AdaptiveSpinner(color: Colors.white)),
        ),
      );
      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(tester.getSize(find.byType(AdaptiveSpinner)), const Size(20, 20));
    });

    testWidgets('Material uses CircularProgressIndicator stroke 2', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          TargetPlatform.android,
          const AdaptiveSpinner(color: Colors.white),
        ),
      );
      final p = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(p.strokeWidth, 2);
      expect(find.byType(CupertinoActivityIndicator), findsNothing);
    });
  });

  group('AppIcons', () {
    testWidgets('picks per platform', (tester) async {
      late BuildContext apple;
      late BuildContext material;
      await tester.pumpWidget(
        _app(
          TargetPlatform.iOS,
          Builder(
            builder: (c) {
              apple = c;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(AppIcons.person(apple), CupertinoIcons.person);
      expect(AppIcons.lock(apple), CupertinoIcons.lock);
      expect(AppIcons.eye(apple), CupertinoIcons.eye);
      expect(AppIcons.eyeSlash(apple), CupertinoIcons.eye_slash);

      await tester.pumpWidget(
        _app(
          TargetPlatform.android,
          Builder(
            builder: (c) {
              material = c;
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(AppIcons.person(material), Icons.person_outline_rounded);
      expect(AppIcons.lock(material), Icons.lock_outline_rounded);
      expect(AppIcons.eye(material), Icons.visibility_outlined);
      expect(AppIcons.eyeSlash(material), Icons.visibility_off_outlined);
    });
  });
}
