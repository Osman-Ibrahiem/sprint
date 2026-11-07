import 'package:flutter/material.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';

class LoginIdentifierField extends StatelessWidget {
  const LoginIdentifierField({
    required this.onChanged,
    this.errorText,
    this.controller,
    super.key,
  });

  final ValueChanged<String> onChanged;
  final String? errorText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Semantics(
      label: l10n.loginIdentifierSemantic,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: l10n.loginIdentifierHint,
          prefixIcon: const ExcludeSemantics(
            child: Icon(Icons.person_outline_rounded),
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
