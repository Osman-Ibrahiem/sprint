import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sprint/core/presentation/screens/error_screen.dart';
import 'package:sprint/core/router/app_routes.dart';
import 'package:sprint/features/auth/presentation/screens/login_screen.dart';
import 'package:sprint/features/home/domain/home_session.dart';
import 'package:sprint/features/home/presentation/screens/home_screen.dart';
import 'package:sprint/features/splash/presentation/screens/splash_screen.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.initial,
    errorBuilder: (context, state) => const ErrorScreen(),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => HomeScreen(
          session: HomeSession.parse(state.uri.queryParameters['session']),
        ),
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
