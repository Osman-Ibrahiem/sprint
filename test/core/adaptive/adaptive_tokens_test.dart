import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/core/adaptive/adaptive_tokens.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/size_class.dart';

void main() {
  test('token lookup matches Figma Layout collection', () {
    final c = AdaptiveTokens.of(SizeClass.compact);
    expect(
      [c.columns, c.margin, c.gutter, c.maxContentWidth, c.panes],
      [4, 24, 16, 600, 1],
    );
    expect(c.navType, NavType.bottomBar);

    final m = AdaptiveTokens.of(SizeClass.medium);
    expect([m.columns, m.margin, m.maxContentWidth], [8, 32, 840]);
    expect(m.navType, NavType.rail);

    final e = AdaptiveTokens.of(SizeClass.expanded);
    expect(
      [e.columns, e.margin, e.gutter, e.panes, e.startPaneWidth],
      [12, 40, 24, 2, 360],
    );
    expect(e.isTwoPane, isTrue);

    final l = AdaptiveTokens.of(SizeClass.large);
    expect([l.margin, l.maxContentWidth, l.startPaneWidth], [48, 1200, 400]);
    expect(l.navType, NavType.drawer);
  });

  test('splash tokens per class', () {
    expect(SizeClass.values.map((s) => AdaptiveTokens.of(s).splashLogoSize), [
      160,
      200,
      240,
      240,
    ]);
    expect(SizeClass.values.map((s) => AdaptiveTokens.of(s).splashEdgeInset), [
      24,
      32,
      32,
      32,
    ]);
  });

  test('single pane below expanded has no start pane', () {
    for (final s in [SizeClass.compact, SizeClass.medium]) {
      expect(AdaptiveTokens.of(s).isTwoPane, isFalse);
      expect(AdaptiveTokens.of(s).startPaneWidth, 0);
    }
  });

  test('type sizes grow monotonically with size class', () {
    for (var i = 1; i < SizeClass.values.length; i++) {
      final prev = AdaptiveTokens.of(SizeClass.values[i - 1]).type;
      final next = AdaptiveTokens.of(SizeClass.values[i]).type;
      expect(next.h1, greaterThanOrEqualTo(prev.h1));
      expect(next.body, greaterThanOrEqualTo(prev.body));
      expect(next.micro, greaterThanOrEqualTo(prev.micro));
    }
  });

  test('AdaptiveTypography changes size only', () {
    final compact = AdaptiveTypography.of(SizeClass.compact).h1;
    final large = AdaptiveTypography.of(SizeClass.large).h1;
    expect(compact.fontSize, 32);
    expect(large.fontSize, 44);
    expect(large.fontFamily, compact.fontFamily);
    expect(large.fontWeight, compact.fontWeight);
    expect(large.height, compact.height);
  });
}
