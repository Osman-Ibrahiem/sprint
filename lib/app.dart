import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint/core/adaptive/hinge_override.dart';
import 'package:sprint/core/adaptive/hinge_source.dart';
import 'package:sprint/core/adaptive/platform_override.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/providers/hinge_provider.dart';
import 'package:sprint/core/providers/locale_provider.dart';
import 'package:sprint/core/providers/theme_provider.dart';
import 'package:sprint/core/router/app_router.dart';
import 'package:sprint/core/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final platform = PlatformOverride.current;
    final hinge = ref.watch(hingeStatusProvider).value ?? HingeStatus.none;

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      theme: AppTheme.light().copyWith(platform: platform),
      darkTheme: AppTheme.dark().copyWith(platform: platform),
      themeMode: themeMode,
      locale: locale,
      builder: (context, child) {
        final media = MediaQuery.of(context);
        // A build-time override wins; otherwise use the hinge the OS reports.
        final forced = HingeOverride.current;
        final data = forced.isNotEmpty
            ? HingeOverride.apply(media, forced)
            : hinge.splitsScreen
            ? HingeOverride.apply(
                media,
                HingeOverride.modeFor(media.size),
                gap: 0,
              )
            : media;
        return MediaQuery(data: data, child: child!);
      },
      routerConfig: ref.watch(appRouterProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
