import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _precacheStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_precacheStarted) return;
    _precacheStarted = true;
    // Decode the splash image into the Flutter image cache before removing the
    // native splash overlay. This guarantees the icon is present on the exact
    // frame the native splash disappears — no blank-frame gap.
    precacheImage(
      const AssetImage('assets/splash/splash_image.png'),
      context,
    ).whenComplete(FlutterNativeSplash.remove);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // if (mounted) context.go(AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.green900,
      body: Stack(
        children: [
          Center(child: SplashIcon()),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.lime),
            ),
          ),
        ],
      ),
    );
  }
}
