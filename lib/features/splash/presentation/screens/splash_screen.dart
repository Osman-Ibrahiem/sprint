import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sprint/core/router/app_routes.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_app_name.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_background.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_loading_bar.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_logo.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _revealController;
  late final Animation<double> _revealAnim;
  bool _contentVisible = false;
  Timer? _revealTimer;
  Timer? _navTimer;

  // Phase 1 (0–400ms): solid bg + centered logo, pixel-identical to native splash.
  // Phase 2 (400ms+): gradient + app name + loading bar fade in.
  static const Duration _transitionDelay = Duration(milliseconds: 400);
  static const Duration _revealDuration = Duration(milliseconds: 600);
  // Loading bar runs 1800ms from phase-2 start; navigate 100ms after it finishes.
  static const Duration _navDelay = Duration(milliseconds: 2300);

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      duration: _revealDuration,
      vsync: this,
    );
    _revealAnim = CurvedAnimation(
      parent: _revealController,
      curve: Curves.easeOut,
    );

    _revealTimer = Timer(_transitionDelay, () {
      if (mounted) {
        setState(() => _contentVisible = true);
        _revealController.forward();
      }
    });

    _navTimer = Timer(_navDelay, () {
     // if (mounted) context.go(AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _revealTimer?.cancel();
    _navTimer?.cancel();
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green900,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient overlay — invisible during phase 1, fades in with content.
          FadeTransition(opacity: _revealAnim, child: const SplashBackground()),

          // Logo starts at exact screen center (phase 1).
          // AnimatedSize grows the text section below the logo, pushing it up
          // smoothly as phase 2 reveals — no discrete position jump.
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SplashLogo(),
                AnimatedSize(
                  duration: _revealDuration,
                  curve: Curves.easeOut,
                  child: _contentVisible
                      ? FadeTransition(
                          opacity: _revealAnim,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: SplashAppName(),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),

          // Loading bar built only in phase 2 so TweenAnimationBuilder
          // starts at t=400ms rather than t=0.
          if (_contentVisible)
            PositionedDirectional(
              bottom: 80,
              start: 0,
              end: 0,
              child: FadeTransition(
                opacity: _revealAnim,
                child: const Center(child: SplashLoadingBar()),
              ),
            ),
        ],
      ),
    );
  }
}
