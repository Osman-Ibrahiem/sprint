import 'package:flutter/widgets.dart';
import 'package:sprint/core/adaptive/adaptive_tokens.dart';
import 'package:sprint/core/adaptive/size_class.dart';

/// Exposes the [SizeClass] of the pane's own width to descendants, so tokens
/// inside a pane follow the pane rather than the window.
///
/// Place one around a pane's content (or the whole screen for single-pane
/// layouts). Window-level class decides structure only.
class PaneScope extends StatelessWidget {
  const PaneScope({required this.child, super.key});

  final Widget child;

  /// Size class of the nearest pane; falls back to the window class when
  /// there is no [PaneScope] above [context].
  static SizeClass of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_PaneInherited>();
    return scope?.sizeClass ?? SizeClass.ofWindow(context);
  }

  /// Tokens for the nearest pane's size class.
  static AdaptiveTokens tokensOf(BuildContext context) =>
      AdaptiveTokens.of(of(context));

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        return _PaneInherited(
          sizeClass: SizeClass.fromWidth(width),
          child: child,
        );
      },
    );
  }
}

class _PaneInherited extends InheritedWidget {
  const _PaneInherited({required this.sizeClass, required super.child});

  final SizeClass sizeClass;

  @override
  bool updateShouldNotify(_PaneInherited oldWidget) =>
      sizeClass != oldWidget.sizeClass;
}
