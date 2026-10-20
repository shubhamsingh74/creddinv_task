import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/constants/app_layout.dart';
import 'package:creddinv_task/core/router/app_router.dart';
import 'package:creddinv_task/core/theme/app_theme.dart';
import 'package:creddinv_task/data/repositories/local_auth_repository.dart';
import 'package:creddinv_task/data/repositories/local_product_repository.dart';
import 'package:creddinv_task/features/auth/bloc/auth_bloc.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';
import 'package:creddinv_task/features/products/bloc/catalog_bloc.dart';
import 'package:creddinv_task/features/products/bloc/product_bloc.dart';
import 'package:creddinv_task/features/products/bloc/saved_bloc.dart';

class CreddinvApp extends StatefulWidget {
  const CreddinvApp({super.key});

  @override
  State<CreddinvApp> createState() => _CreddinvAppState();
}

class _CreddinvAppState extends State<CreddinvApp> {
  late final AuthBloc _authBloc;
  late final ProductBloc _productBloc;
  late final CartBloc _cartBloc;
  late final CatalogBloc _catalogBloc;
  late final SavedBloc _savedBloc;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(authRepository: const LocalAuthRepository());
    _productBloc = ProductBloc(
      productRepository: const LocalProductRepository(),
    )..add(const ProductsRequested());
    _cartBloc = CartBloc();
    _catalogBloc = CatalogBloc();
    _savedBloc = SavedBloc();
    _appRouter = AppRouter(authBloc: _authBloc);
  }

  @override
  void dispose() {
    _appRouter.dispose();
    unawaited(_authBloc.close());
    unawaited(_productBloc.close());
    unawaited(_cartBloc.close());
    unawaited(_catalogBloc.close());
    unawaited(_savedBloc.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authBloc),
        BlocProvider.value(value: _productBloc),
        BlocProvider.value(value: _cartBloc),
        BlocProvider.value(value: _catalogBloc),
        BlocProvider.value(value: _savedBloc),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous is AuthAuthenticated && current is AuthUnauthenticated,
        listener: (context, state) {
          context.read<CartBloc>().add(const CartCleared());
          context.read<SavedBloc>().add(const SavedCleared());
          context.read<CatalogBloc>().add(const CatalogReset());
        },
        child: ScreenUtilInit(
          designSize: AppLayout.designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              title: 'Creddinv',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              routerConfig: _appRouter.router,
            );
          },
        ),
      ),
    );
  }
}
