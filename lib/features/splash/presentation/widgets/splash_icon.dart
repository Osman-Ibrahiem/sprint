import 'package:flutter/material.dart';

// 256dp matches the native splash icon size across all platforms:
// Android (mdpi→xxxhdpi density buckets), iOS (@1x/@2x/@3x variants), and web.
const double _kNativeIconSize = 256;

class SplashIcon extends StatelessWidget {
  const SplashIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/splash/splash_image.png',
      width: _kNativeIconSize,
      height: _kNativeIconSize,
      fit: BoxFit.contain,
    );
  }
}
