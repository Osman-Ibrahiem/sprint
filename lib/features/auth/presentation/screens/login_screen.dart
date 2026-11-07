import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/features/auth/presentation/notifiers/login_form_notifier.dart';
import 'package:sprint/features/auth/presentation/widgets/login_brand_header.dart';
import 'package:sprint/features/auth/presentation/widgets/login_button.dart';
import 'package:sprint/features/auth/presentation/widgets/login_identifier_field.dart';
import 'package:sprint/features/auth/presentation/widgets/login_password_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginFormNotifierProvider);
    final notifier = ref.read(loginFormNotifierProvider.notifier);
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPad,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSpacing.xxxl),
                      const LoginBrandHeader(),
                      const SizedBox(height: AppSpacing.xxxl),
                      LoginIdentifierField(
                        onChanged: notifier.setIdentifierText,
                        errorText: state.identifierError,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      LoginPasswordField(
                        onChanged: notifier.setPasswordText,
                        isVisible: state.isPasswordVisible,
                        onToggleVisibility: notifier.togglePasswordVisibility,
                        errorText: state.passwordError,
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      LoginButton(
                        onPressed: notifier.mockLogin,
                        isLoading: state.isLoading,
                      ),
                      const SizedBox(height: AppSpacing.xxxl),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
