import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/providers/locale_provider.dart';
import 'package:sprint/core/providers/theme_provider.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_typography.dart';

class LoginPlaceholderScreen extends ConsumerWidget {
  const LoginPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.sprintGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.bolt_rounded,
                size: 28,
                color: AppColors.lime,
              ),
            ),
            const SizedBox(height: 16),
            Text(l10n.appName, style: AppTypography.h1),
            const SizedBox(height: 8),
            Text(l10n.loginTitle, style: AppTypography.body),
            const SizedBox(height: 4),
            Text(
              l10n.loginSubtitle,
              style: AppTypography.sm.copyWith(color: AppColors.textSecondary),
            ),
            if (kDebugMode) ...[
              //const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      final current = ref.read(themeModeNotifierProvider);
                      ref.read(themeModeNotifierProvider.notifier).setTheme(
                        current == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark,
                      );
                    },
                    child: const Text('Toggle Theme'),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      final current = ref.read(localeNotifierProvider);
                      ref.read(localeNotifierProvider.notifier).setLocale(
                        current.languageCode == 'ar'
                            ? const Locale('en')
                            : const Locale('ar'),
                      );
                    },
                    child: const Text('Toggle Locale'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ],
        ),
      ),
    );
  }
}
