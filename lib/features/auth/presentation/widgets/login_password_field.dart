import 'package:flutter/material.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({
    required this.onChanged,
    required this.isVisible,
    required this.onToggleVisibility,
    this.errorText,
    this.controller,
    super.key,
  });

  final ValueChanged<String> onChanged;
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  final String? errorText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Semantics(
      label: l10n.loginPasswordSemantic,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        obscureText: !isVisible,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: l10n.loginPasswordHint,
          suffixIcon: IconButton(
            icon: Icon(
              isVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            tooltip: isVisible
                ? l10n.loginPasswordHide
                : l10n.loginPasswordShow,
            onPressed: onToggleVisibility,
          ),
          errorText: errorText,
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: AppRadius.mdAll,
            borderSide: BorderSide(color: AppColors.error, width: 2),
          ),
        ),
      ),
    );
  }
}
