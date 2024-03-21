import 'package:flutter/material.dart';
import 'package:frontend/presentation/pages/AI_test/AI_test.dart';
import 'package:frontend/presentation/pages/login/login_page.dart';
import 'package:frontend/presentation/pages/main_screen/main_screen.dart';
import 'package:frontend/presentation/pages/mypage/my_page_background.dart';
import 'package:frontend/presentation/pages/quiz/book_quiz_page.dart';
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
    GoRoute(
      path: RoutePath.aiTest,
      name: 'aitest',
      builder: (context, state) => const AITest(),
    ),
    GoRoute(
      path: RoutePath.bookquiz,
      builder: (context, state) {
        // 여기서 state.params를 사용하여 bookId를 얻을 수 있습니다.
        final bookId = state.pathParameters['bookId'];
        return BookQuizPage(bookId: bookId);
      },
    ),
  ],
  initialLocation: RoutePath.splash,
);
