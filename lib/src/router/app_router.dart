import 'package:bolsifyv2/src/features/auth/view/auth_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bolsifyv2/src/features/splash/view/splash_view.dart';
import 'package:bolsifyv2/src/features/home/view/home_view.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthView(),
      )
    ],
  );
});
