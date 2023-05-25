
import 'package:go_router/go_router.dart';
import 'package:msaver/constant/string_constant.dart';
import 'package:msaver/screen/home/home_screen.dart';
import 'package:msaver/screen/setup_profile/setup_profile.dart';
import 'package:msaver/screen/splash/splash_screen.dart';

class RouteScreen {
  final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: StringConstant.home,
      builder: (context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: StringConstant.setupProfile,
      builder: (context, GoRouterState state) {
        return const SetupProfileScreen();
      },
    )
  ], initialLocation: '/');
}
