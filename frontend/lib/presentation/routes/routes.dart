import 'package:frontend/presentation/pages/login/login_page.dart';
import 'package:frontend/presentation/pages/main_screen/main_screen.dart';
import 'package:frontend/presentation/pages/mypage/my_page_background.dart';
import 'package:go_router/go_router.dart';

import '../pages/splash/splash_page.dart';
import 'route_path.dart';

final GoRouter globalRouter = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.splash,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RoutePath.main,
      name: 'main',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return MainScreen(id: id ?? '0',);
      },
    ),
    GoRoute(
      path: RoutePath.myPage,
      name: 'myPage',
      builder: (context, state) => const MyPageBackground(),
    ),
    GoRoute(
      path: RoutePath.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
  ],
  initialLocation: RoutePath.splash,
);
