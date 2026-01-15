import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:blog_app/features/auth/auth_routes.dart' as auth_routes;

// Minimal placeholder screens used as defaults when the project
// doesn't yet provide splash / error screens.
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _SomethingWentWrongScreen extends StatelessWidget {
  final GoRouterState? state;
  const _SomethingWentWrongScreen({this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Something went wrong.'),
            const SizedBox(height: 8),
            if (state != null) Text(state!.error.toString()),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go(_SplashScreen.route),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class AppRouter {
  AppRouter._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final _router = GoRouter(
    navigatorKey: navigatorKey,
    // Start the app on the sign-in route so users see the login screen
    // instead of being stuck on the placeholder splash loader.
    initialLocation: '/sign-in',
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: _SplashScreen.route,
        name: 'splash',
        builder: (context, state) => const _SplashScreen(),
      ),
      ...auth_routes.AuthRoutes.routes,
    ],
    errorBuilder: (context, state) => _SomethingWentWrongScreen(state: state),
    redirect: (context, state) {
      // Add auth redirect logic here when auth is available.
      return null;
    },
  );

  static void go(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    try {
      // Prefer the router instance directly so callers don't need a BuildContext
      // that already contains a GoRouter (prevents "No GoRouter found in context").
      router.goNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    } catch (e) {
      debugPrint('Navigation error: $e');
      router.go(_SplashScreen.route);
    }
  }

  static void replace(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    try {
      // Use router to avoid relying on the passed context
      router.replaceNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    } catch (e) {
      debugPrint('Replace error: $e');
      router.go(_SplashScreen.route);
    }
  }

  static Future<T?> push<T extends Object?>(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    try {
      return await router.pushNamed<T>(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    } catch (e) {
      debugPrint('Push named error: $e');
      return null;
    }
  }

  static void pop(BuildContext context, {Object? result}) {
    try {
      if (router.canPop()) {
        router.pop(result);
      } else {
        debugPrint('Cannot pop, navigating to home');
        router.go(_SplashScreen.route);
      }
    } catch (e) {
      debugPrint('Pop error: $e');
    }
  }

  static void goHome(BuildContext context) {
    router.go(_SplashScreen.route);
  }

  static bool canPop(BuildContext context) {
    return router.canPop();
  }

  static String currentLocation(BuildContext context) {
    try {
      final location = GoRouterState.of(context).uri.toString();
      debugPrint('Current location: $location');
      return location;
    } catch (_) {
      final fallback = router.routerDelegate.currentConfiguration.toString();
      debugPrint('Current location (fallback): $fallback');
      return fallback;
    }
  }

  static void popOrGoHome(BuildContext context) {
    if (router.canPop()) {
      router.pop();
    } else {
      goHome(context);
    }
  }
}
