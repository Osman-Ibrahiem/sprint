import 'package:flutter/material.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_typography.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    required this.onPressed,
    required this.isLoading,
    super.key,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Semantics(
      label: l10n.loginButtonSemantic,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.sprintGreen,
                ),
              )
            : Text(
                l10n.loginButton,
                style: AppTypography.bodyLg.copyWith(
                  fontWeight: AppTypography.extraBold,
                ),
              ),
      ),
    );
  }
}
