import 'package:sprint/core/adaptive/size_class.dart';

/// Navigation pattern chosen per size class (Figma `layout/nav-type`).
enum NavType { bottomBar, rail, drawer }

/// Type sizes (dp) for one size class (Figma `Type scale` collection).
class TypeScaleTokens {
  const TypeScaleTokens({
    required this.displayXl,
    required this.display,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.bodyLg,
    required this.body,
    required this.sm,
    required this.xs,
    required this.micro,
  });

  final double displayXl;
  final double display;
  final double h1;
  final double h2;
  final double h3;
  final double bodyLg;
  final double body;
  final double sm;
  final double xs;
  final double micro;
}

/// Layout and type tokens for one [SizeClass].
/// Source of truth: Figma variable collections `Layout` and `Type scale`.
class AdaptiveTokens {
  const AdaptiveTokens({
    required this.columns,
    required this.margin,
    required this.gutter,
    required this.maxContentWidth,
    required this.panes,
    required this.navType,
    required this.startPaneWidth,
    required this.splashLogoSize,
    required this.splashEdgeInset,
    required this.type,
  });

  final int columns;

  /// Responsive screen margin; replaces fixed `AppSpacing.screenPad` on screens.
  final double margin;
  final double gutter;
  final double maxContentWidth;
  final int panes;
  final NavType navType;

  /// Width of the start (brand) pane when [panes] is 2; 0 otherwise.
  final double startPaneWidth;
  final double splashLogoSize;
  final double splashEdgeInset;
  final TypeScaleTokens type;

  bool get isTwoPane => panes > 1;

  static const AdaptiveTokens compact = AdaptiveTokens(
    columns: 4,
    margin: 24,
    gutter: 16,
    maxContentWidth: 600,
    panes: 1,
    navType: NavType.bottomBar,
    startPaneWidth: 0,
    splashLogoSize: 160,
    splashEdgeInset: 24,
    type: TypeScaleTokens(
      displayXl: 48,
      display: 40,
      h1: 32,
      h2: 26,
      h3: 20,
      bodyLg: 16,
      body: 15,
      sm: 14,
      xs: 12,
      micro: 11,
    ),
  );

  static const AdaptiveTokens medium = AdaptiveTokens(
    columns: 8,
    margin: 32,
    gutter: 16,
    maxContentWidth: 840,
    panes: 1,
    navType: NavType.rail,
    startPaneWidth: 0,
    splashLogoSize: 200,
    splashEdgeInset: 32,
    type: TypeScaleTokens(
      displayXl: 56,
      display: 44,
      h1: 36,
      h2: 28,
      h3: 22,
      bodyLg: 17,
      body: 16,
      sm: 14,
      xs: 12,
      micro: 11,
    ),
  );

  static const AdaptiveTokens expanded = AdaptiveTokens(
    columns: 12,
    margin: 40,
    gutter: 24,
    maxContentWidth: 840,
    panes: 2,
    navType: NavType.rail,
    startPaneWidth: 360,
    splashLogoSize: 240,
    splashEdgeInset: 32,
    type: TypeScaleTokens(
      displayXl: 64,
      display: 52,
      h1: 40,
      h2: 32,
      h3: 24,
      bodyLg: 18,
      body: 16,
      sm: 15,
      xs: 13,
      micro: 12,
    ),
  );

  static const AdaptiveTokens large = AdaptiveTokens(
    columns: 12,
    margin: 48,
    gutter: 24,
    maxContentWidth: 1200,
    panes: 2,
    navType: NavType.drawer,
    startPaneWidth: 400,
    splashLogoSize: 240,
    splashEdgeInset: 32,
    type: TypeScaleTokens(
      displayXl: 72,
      display: 60,
      h1: 44,
      h2: 34,
      h3: 26,
      bodyLg: 18,
      body: 17,
      sm: 15,
      xs: 13,
      micro: 12,
    ),
  );

  static AdaptiveTokens of(SizeClass sizeClass) => switch (sizeClass) {
    SizeClass.compact => compact,
    SizeClass.medium => medium,
    SizeClass.expanded => expanded,
    SizeClass.large => large,
  };
}

/// Splash rules for short windows (Figma: Flip7 cover 420 dp, Duo landscape
/// 466 dp). Below [splashShortHeight] the spinner is dropped and the logo is
/// capped at [splashShortLogoFraction] of the height.
abstract final class SplashLimits {
  static const double splashShortHeight = 600;
  static const double splashShortLogoFraction = 0.33;

  static bool isShort(double height) => height < splashShortHeight;

  /// Final logo size for a window of [height] given the class [tokenSize].
  static double logoSize(double tokenSize, double height) {
    if (!isShort(height)) return tokenSize;
    final cap = (height * splashShortLogoFraction).floorToDouble();
    return cap < tokenSize ? cap : tokenSize;
  }
}
