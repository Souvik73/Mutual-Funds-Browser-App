import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../controllers/scheme_detail_controller.dart';
import '../services/api_service.dart';
import '../views/login_screen.dart';
import '../views/scheme_list_screen.dart';
import '../views/scheme_detail_screen.dart';

class AppRouter {
  AppRouter(this._authController, this._apiService);

  final AuthController _authController;
  final ApiService _apiService;

  late final GoRouter router = GoRouter(
    initialLocation: '/login',
    refreshListenable: _authController,
    redirect: _redirect,
    routes: _routes,
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final authenticated = _authController.isAuthenticated;
    final onLogin = state.matchedLocation == '/login';

    if (!authenticated && !onLogin) return '/login';
    if (authenticated && onLogin) return '/list';
    return null;
  }

  List<RouteBase> get _routes => [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/list',
          builder: (context, state) => const SchemeListScreen(),
        ),
        GoRoute(
          path: '/scheme/:code',
          builder: (context, state) {
            final code = int.parse(state.pathParameters['code']!);
            return ChangeNotifierProvider(
              create: (_) => SchemeDetailController(_apiService),
              child: SchemeDetailScreen(schemeCode: code),
            );
          },
        ),
      ];
}
