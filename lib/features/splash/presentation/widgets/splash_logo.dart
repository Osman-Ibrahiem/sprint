import 'package:flutter/material.dart';
import 'package:sprint/core/theme/app_colors.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118,
      height: 118,
      decoration: BoxDecoration(
        color: AppColors.sprintGreen,
        borderRadius: BorderRadius.circular(38),
        boxShadow: const [
          BoxShadow(
            color: Color(0x990F4C2F),
            blurRadius: 50,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: const Icon(
        Icons.bolt_rounded,
        size: 70,
        color: AppColors.lime,
      ),
    );
  }
}
