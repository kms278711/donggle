import 'package:frontend/presentation/pages/card/card_page.dart';
import 'package:frontend/presentation/pages/home/home_page.dart';
import 'package:frontend/presentation/pages/login/login_page.dart';
import 'package:frontend/presentation/pages/mypage/my_page.dart';
import 'package:go_router/go_router.dart';

import '../pages/splash/splash_page.dart';
import 'route_path.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePath.splash,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RoutePath.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: RoutePath.card,
      name: 'card',
      builder: (context, state) => const CardPage(),
    ),
    GoRoute(
      path: RoutePath.myPage,
      name: 'myPage',
      builder: (context, state) => const MyPage(),
    ),
    GoRoute(
      path: RoutePath.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
  ],
  initialLocation: RoutePath.splash,
);
