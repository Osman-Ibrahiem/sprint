import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint/features/auth/presentation/login_layout.dart';
import 'package:sprint/features/auth/presentation/notifiers/login_form_notifier.dart';
import 'package:sprint/features/auth/presentation/widgets/login_button.dart';
import 'package:sprint/features/auth/presentation/widgets/login_identifier_field.dart';
import 'package:sprint/features/auth/presentation/widgets/login_password_field.dart';

/// Identifier + password fields and the login button.
class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginFormProvider);
    final notifier = ref.read(loginFormProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LoginIdentifierField(
          onChanged: notifier.setIdentifierText,
          errorText: state.identifierError,
        ),
        const SizedBox(height: LoginLayout.fieldGap),
        LoginPasswordField(
          onChanged: notifier.setPasswordText,
          isVisible: state.isPasswordVisible,
          onToggleVisibility: notifier.togglePasswordVisibility,
          errorText: state.passwordError,
        ),
        const SizedBox(height: LoginLayout.fieldGap + LoginLayout.buttonTopGap),
        LoginButton(onPressed: notifier.mockLogin, isLoading: state.isLoading),
      ],
    );
  }
}
