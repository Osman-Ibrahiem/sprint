import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_icon.dart';
import 'package:sprint/features/splash/presentation/widgets/splash_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      body: SplashBackground(
        child: Stack(
          children: [
            Center(child: SplashIcon()),
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.lime,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
