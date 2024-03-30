import 'package:frontend/presentation/pages/book/book_progress.dart';
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
        final bookId = state.pathParameters['bookId'];
        return MainScreen(id: id ?? '0', bookId: bookId ?? '0');
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
      path: RoutePath.bookProgress,
      name: 'bookProgress',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        final pageId = state.pathParameters['pageId'];
        final isForward = state.pathParameters['isForward'];
        return BookProgress(id ?? '0', pageId ?? '0', isForward ?? '0');
      },
    )
    // GoRoute(
    //   path: RoutePath.bookquiz,
    //   builder: (context, state) {
    //     // 여기서 state.params를 사용하여 bookId를 얻을 수 있습니다.
    //     final bookId = state.pathParameters['bookId'];
    //     return BookQuizPage(bookId: bookId);
    //   },
    // ),
  ],
  initialLocation: RoutePath.splash,
);
