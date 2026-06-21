import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/router/app_routes.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.errorPageTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.errorPageMessage),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.go(AppRoutes.home),
              child: Text(l10n.backToHome),
            ),
          ],
        ),
      ),
    );
  }
}
