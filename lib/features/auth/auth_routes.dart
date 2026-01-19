import 'package:blog_app/features/auth/presentation/screens/login_screen.dart';
import 'package:blog_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:blog_app/features/auth/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      path: '/sign-in',
      name: LogInScreen.name,
      builder: (context, routeState) {
        return const LogInScreen();
      },
    ),

    GoRoute(
      path: '/sign-up',
      name: SignUpScreen.name,
      builder: (context, routeState) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path: '/home',
      name: HomeScreen.name,
      builder: (context, routeState) {
        return const HomeScreen();
      },
    ),
  ];
}
