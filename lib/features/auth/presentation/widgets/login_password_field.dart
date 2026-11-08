import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_metrics.dart';
import 'package:sprint/core/adaptive/app_icons.dart';
import 'package:sprint/core/adaptive/app_platform.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/presentation/widgets/adaptive/adaptive_text_field.dart';

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
    final box = FieldMetrics.of(AppPlatform.of(context)).trailingBox;

    return AdaptiveTextField(
      controller: controller,
      onChanged: onChanged,
      hintText: l10n.loginPasswordHint,
      semanticLabel: l10n.loginPasswordSemantic,
      errorText: errorText,
      obscureText: !isVisible,
      textInputAction: TextInputAction.done,
      leading: AppIcons.lock(context),
      trailing: IconButton(
        padding: EdgeInsets.zero,
        constraints: BoxConstraints.tight(Size.square(box)),
        icon: Icon(
          isVisible ? AppIcons.eye(context) : AppIcons.eyeSlash(context),
        ),
        tooltip: isVisible ? l10n.loginPasswordHide : l10n.loginPasswordShow,
        onPressed: onToggleVisibility,
      ),
    );
  }
}
