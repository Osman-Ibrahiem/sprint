import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:sprint/core/adaptive/adaptive_tokens.dart';
import 'package:sprint/core/adaptive/size_class.dart';
import 'package:sprint/core/router/app_routes.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_app_name.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_corner_brackets.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_footer.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_glow.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _precacheStarted = false;
  late final AnimationController _phase2;

  // Phase 1: icon at 256dp matching native splash.
  // Phase 2: icon shrinks to the size-class logo size (160/200/240, less on
  // short windows), text + glows + brackets fade in.
  static const double _kPhase1Size = 256;

  // 500ms hold so the user sees the phase-1 icon before the transition starts.
  static const Duration _kPhase1Hold = Duration(milliseconds: 500);

  // Total phase-2 duration: 2800ms broken into two sequential stages.
  static const Duration _kPhase2Duration = Duration(milliseconds: 2800);

  // Interval boundaries as fractions of 2800ms:
  //   0 → 600ms  : logo shrinks 256 → 160dp
  //   600 → 1400ms: content (text, glows, brackets) fades + sizes in
  static const double _tLogoEnd = 600 / 2800;
  static const double _tContentEnd = 1400 / 2800;

  late final Animation<double> _logoT;
  late final Animation<double> _contentReveal;

  @override
  void initState() {
    super.initState();
    _phase2 = AnimationController(duration: _kPhase2Duration, vsync: this);

    _logoT = CurvedAnimation(
      parent: _phase2,
      curve: const Interval(0.0, _tLogoEnd, curve: Curves.easeInOut),
    );

    _contentReveal = CurvedAnimation(
      parent: _phase2,
      curve: const Interval(_tLogoEnd, _tContentEnd, curve: Curves.easeOut),
    );

    _phase2.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        context.go(AppRoutes.login);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_precacheStarted) return;
    _precacheStarted = true;
    // Decode the splash image into cache before removing the native overlay so
    // the icon is present on the exact frame the native splash disappears.
    precacheImage(
      const AssetImage('assets/splash/splash_image.png'),
      context,
    ).whenComplete(() {
      FlutterNativeSplash.remove();
      Future.delayed(_kPhase1Hold, () {
        if (mounted) _phase2.forward();
      });
    });
  }

  @override
  void dispose() {
    _phase2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final tokens = AdaptiveTokens.of(SizeClass.fromWidth(size.width));
    final logoEnd = SplashLimits.logoSize(tokens.splashLogoSize, size.height);
    final showSpinner = !SplashLimits.isShort(size.height);

    return Scaffold(
      backgroundColor: AppColors.green900,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Stage 2 — atmospheric green glow fades in with content reveal.
          FadeTransition(opacity: _contentReveal, child: const SplashGlow()),

          // Stage 2 — corner bracket decorations.
          FadeTransition(
            opacity: _contentReveal,
            child: const SplashCornerBrackets(),
          ),

          // Stage 1+2 — bolt shrinks 256→160dp (stage 1),
          //             then content reveals below it (stage 2).
          //
          // One centered group: logo → gap → text, all in a single
          // min-size Column under Center so the whole unit re-centers
          // as content reveals. Gap gets its own SizeTransition so the
          // text column never starts with blank space (which caused the
          // visual disconnect between logo and text during the animation).
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo: animates from 256dp → 160dp over the first 600ms.
                AnimatedBuilder(
                  animation: _logoT,
                  builder: (context, _) => SplashIcon(
                    size: lerpDouble(_kPhase1Size, logoEnd, _logoT.value)!,
                  ),
                ),
                // Text + progress: fades and grows in from t=600ms.
                // No blank SizedBox at the top so text appears immediately.
                //
                // alignment: topCenter anchors the grow-from-top clip and is
                // direction-agnostic (no RTL offset).
                SizeTransition(
                  sizeFactor: _contentReveal,
                  alignment: Alignment.topCenter,
                  child: FadeTransition(
                    opacity: _contentReveal,
                    child: const SplashAppName(),
                  ),
                ),
              ],
            ),
          ),

          // Stage 2 — institution badge fades in with content, respects safe area.
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: tokens.splashEdgeInset),
                child: FadeTransition(
                  opacity: _contentReveal,
                  child: SplashFooter(showSpinner: showSpinner),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
