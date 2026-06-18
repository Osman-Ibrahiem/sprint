import 'package:flutter/material.dart';

class SplashIcon extends StatelessWidget {
  const SplashIcon({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/splash/splash_image.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
