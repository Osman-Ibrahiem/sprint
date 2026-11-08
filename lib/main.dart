import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprint/app.dart';
import 'package:sprint/core/providers/shared_preferences_provider.dart';
import 'package:sprint/core/router/app_routes.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const App(),
    ),
  );
  // The splash screen removes the native splash itself. A deep link that
  // starts on any other route would never reach it, so remove it here.
  if (PlatformDispatcher.instance.defaultRouteName != AppRoutes.splash) {
    binding.addPostFrameCallback((_) => FlutterNativeSplash.remove());
  }
}
