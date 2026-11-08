import 'package:flutter/material.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_filled_button.dart';

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
      child: AdaptiveFilledButton(
        label: l10n.loginButton,
        onPressed: onPressed,
        isLoading: isLoading,
      ),
    );
  }
}
