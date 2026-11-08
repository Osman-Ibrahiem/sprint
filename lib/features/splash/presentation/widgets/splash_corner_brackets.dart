import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_spacing.dart';

/// Four corner brackets, inset from the edges by the safe area plus the
/// size-class edge inset (Figma `splash/edge-inset`).
class SplashCornerBrackets extends StatelessWidget {
  const SplashCornerBrackets({super.key});

  @override
  Widget build(BuildContext context) {
    final inset = PaneScope.tokensOf(context).splashEdgeInset;
    final safe = MediaQuery.paddingOf(context);
    final left = safe.left + inset;
    final right = safe.right + inset;
    final top = safe.top + inset;
    final bottom = safe.bottom + inset;

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          left: left,
          top: top,
          child: _bracket(top: true, leading: true),
        ),
        Positioned(
          right: right,
          top: top,
          child: _bracket(top: true, leading: false),
        ),
        Positioned(
          left: left,
          bottom: bottom,
          child: _bracket(top: false, leading: true),
        ),
        Positioned(
          right: right,
          bottom: bottom,
          child: _bracket(top: false, leading: false),
        ),
      ],
    );
  }

  Widget _bracket({required bool top, required bool leading}) {
    final side = BorderSide(
      color: AppColors.lime.withValues(alpha: 0.25),
      width: 1,
    );
    return SizedBox(
      width: AppSpacing.xl,
      height: AppSpacing.xl,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: top ? side : BorderSide.none,
            bottom: top ? BorderSide.none : side,
            left: leading ? side : BorderSide.none,
            right: leading ? BorderSide.none : side,
          ),
        ),
      ),
    );
  }
}
