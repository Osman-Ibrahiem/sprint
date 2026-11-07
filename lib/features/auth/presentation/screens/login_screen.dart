import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_tokens.dart';
import 'package:sprint/core/adaptive/flex_posture.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/adaptive/size_class.dart';
import 'package:sprint/features/auth/presentation/login_layout.dart';
import 'package:sprint/features/auth/presentation/widgets/login_brand_header.dart';
import 'package:sprint/features/auth/presentation/widgets/login_brand_pane.dart';
import 'package:sprint/features/auth/presentation/widgets/login_form.dart';
import 'package:sprint/features/auth/presentation/widgets/login_heading.dart';

/// Login. Compact/Medium: one column. Expanded/Large: brand pane + form pane.
/// A half-open foldable (flex posture) puts the header above the hinge and
/// the form below it.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final tokens = AdaptiveTokens.of(SizeClass.fromWidth(media.size.width));
    final flex = FlexPosture.of(media);
    final split = VerticalSplit.of(media);

    final Widget body;
    if (split != null) {
      body = _SplitPanes(split: split, width: media.size.width);
    } else if (tokens.isTwoPane) {
      body = _TwoPane(tokens: tokens, width: media.size.width);
    } else if (flex != null) {
      body = _FlexPane(posture: flex);
    } else {
      body = const _SinglePane();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: body,
    );
  }
}

class _SinglePane extends StatelessWidget {
  const _SinglePane();

  @override
  Widget build(BuildContext context) {
    return const PaneScope(
      child: SafeArea(
        child: _FormScroll(
          children: [
            LoginBrandHeader(),
            SizedBox(height: LoginLayout.headerToForm),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}

class _TwoPane extends StatelessWidget {
  const _TwoPane({required this.tokens, required this.width});

  final AdaptiveTokens tokens;
  final double width;

  @override
  Widget build(BuildContext context) {
    // Form pane is the form column plus margins, but never squeezes the brand
    // pane below its minimum (start-pane) width.
    final formPane = math.min(
      LoginLayout.formWidth + 2 * tokens.margin,
      width - tokens.startPaneWidth,
    );

    return Row(
      children: [
        const Expanded(child: LoginBrandPane()),
        SizedBox(
          width: formPane,
          child: const PaneScope(
            child: SafeArea(
              child: _FormScroll(
                children: [
                  LoginHeading(),
                  SizedBox(height: LoginLayout.headingToForm),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Brand pane and form pane placed on the two screens of a dual-screen device,
/// leaving the hinge gap empty. The brand pane takes the start screen.
class _SplitPanes extends StatelessWidget {
  const _SplitPanes({required this.split, required this.width});

  final VerticalSplit split;
  final double width;

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final leftWidth = split.leftWidth;
    final rightWidth = width - split.rightStart;
    final gap = split.rightStart - split.leftWidth;

    return Row(
      children: [
        SizedBox(
          width: rtl ? rightWidth : leftWidth,
          child: const LoginBrandPane(),
        ),
        SizedBox(width: gap),
        SizedBox(
          width: rtl ? leftWidth : rightWidth,
          child: const PaneScope(
            child: SafeArea(
              child: _FormScroll(
                children: [
                  LoginHeading(),
                  SizedBox(height: LoginLayout.headingToForm),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FlexPane extends StatelessWidget {
  const _FlexPane({required this.posture});

  final FlexPosture posture;

  @override
  Widget build(BuildContext context) {
    return PaneScope(
      child: Column(
        children: [
          SizedBox(
            height: posture.topHeight,
            child: const SafeArea(
              bottom: false,
              child: Center(child: LoginBrandHeader()),
            ),
          ),
          SizedBox(height: posture.bottomStart - posture.topHeight),
          const Expanded(
            child: SafeArea(
              top: false,
              child: _FormScroll(children: [LoginForm()]),
            ),
          ),
        ],
      ),
    );
  }
}

/// Scrollable, centered column capped at the form width with responsive
/// margins. Scrolls the focused field above the keyboard.
class _FormScroll extends StatelessWidget {
  const _FormScroll({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final margin = PaneScope.tokensOf(context).margin;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: LoginLayout.formWidth + 2 * margin,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: margin,
                    vertical: LoginLayout.paneVerticalPad,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
