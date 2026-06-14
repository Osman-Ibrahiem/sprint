import 'package:flutter/material.dart';
import 'package:sprint/core/l10n/app_localizations.dart';

// TODO: replace with feature nav shell when feature branches are ready
class HomeShellScreen extends StatelessWidget {
  const HomeShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appName)),
      body: const Center(child: Text('سبرنت')),
    );
  }
}
