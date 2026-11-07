import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/app_icons.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_text_field.dart';

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

    return AdaptiveTextField(
      controller: controller,
      onChanged: onChanged,
      hintText: l10n.loginIdentifierHint,
      semanticLabel: l10n.loginIdentifierSemantic,
      errorText: errorText,
      leading: AppIcons.person(context),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }
}
