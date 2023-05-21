
import 'package:go_router/go_router.dart';
import 'package:msaver/screen/home/home_screen.dart';

class RouteScreen {
  final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, GoRouterState state) {
        return const HomeScreen();
      },
    )
  ], );
}
