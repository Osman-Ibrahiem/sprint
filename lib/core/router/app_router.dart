import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprint/core/presentation/screens/error_screen.dart';
import 'package:sprint/core/presentation/screens/home_shell_screen.dart';
import 'package:sprint/core/router/app_routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    errorBuilder: (context, state) => const ErrorScreen(),
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeShellScreen(),
      ),
      GoRoute(
        path: AppRoutes.error,
        name: 'error',
        builder: (context, state) => const ErrorScreen(),
      ),
    ],
    redirect: (context, state) => null,
  );
}
