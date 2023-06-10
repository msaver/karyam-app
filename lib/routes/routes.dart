

import 'package:go_router/go_router.dart';
import 'package:karyam/constant/string_constant.dart';
import 'package:karyam/screen/about_us/about_us.dart';
import 'package:karyam/screen/home/home_screen.dart';
import 'package:karyam/screen/setup_profile/setup_profile.dart';
import 'package:karyam/screen/splash/splash_screen.dart';

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
      name: "Home",
      builder: (context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(path: 'about', builder: (context, state){
          return AboutUsScreen();
        })

      ]
    ),
    GoRoute(
      path: StringConstant.setupProfile,
      builder: (context, GoRouterState state) {
        return const SetupProfileScreen();
      },
    )
  ], initialLocation: '/');
}
