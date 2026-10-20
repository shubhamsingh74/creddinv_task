import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:creddinv_task/core/router/app_routes.dart';
import 'package:creddinv_task/core/router/go_router_refresh_stream.dart';
import 'package:creddinv_task/core/router/route_error_screen.dart';
import 'package:creddinv_task/features/auth/bloc/auth_bloc.dart';
import 'package:creddinv_task/features/auth/bloc/login_bloc.dart';
import 'package:creddinv_task/features/auth/presentation/login_screen.dart';
import 'package:creddinv_task/features/cart/presentation/cart_screen.dart';
import 'package:creddinv_task/features/checkout/bloc/checkout_bloc.dart';
import 'package:creddinv_task/features/checkout/data/payment_gateway_registry.dart';
import 'package:creddinv_task/features/checkout/presentation/checkout_screen.dart';
import 'package:creddinv_task/features/products/presentation/product_listing_screen.dart';

class AppRouter {
  AppRouter({required AuthBloc authBloc}) : _authBloc = authBloc {
    _refreshListenable = GoRouterRefreshStream(_authBloc.stream);
    router = GoRouter(
      initialLocation: AppRoutes.login,
      refreshListenable: _refreshListenable,
      redirect: _redirect,
      errorBuilder: (context, state) => const RouteErrorScreen(),
      routes: [
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) {
            return BlocProvider(
              create: (_) => LoginBloc(),
              child: const LoginScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.products,
          builder: (context, state) => const ProductListingScreen(),
        ),
        GoRoute(
          path: AppRoutes.cart,
          builder: (context, state) => const CartScreen(),
        ),
        GoRoute(
          path: AppRoutes.checkout,
          builder: (context, state) {
            return BlocProvider(
              create: (_) =>
                  CheckoutBloc(gateways: const PaymentGatewayRegistry()),
              child: const CheckoutScreen(),
            );
          },
        ),
      ],
    );
  }

  final AuthBloc _authBloc;
  late final GoRouterRefreshStream _refreshListenable;
  late final GoRouter router;

  /// Signed-out visitors stay on login. A signed-in user leaves login.
  String? _redirect(BuildContext context, GoRouterState state) {
    final loggedIn = _authBloc.state is AuthAuthenticated;
    final onLogin = state.matchedLocation == AppRoutes.login;

    if (!loggedIn && !onLogin) return AppRoutes.login;
    if (loggedIn && onLogin) return AppRoutes.products;
    return null;
  }

  void dispose() {
    router.dispose();
    _refreshListenable.dispose();
  }
}
