import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/constants/app_strings.dart';
import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/shared/widgets/app_scaffold.dart';
import 'package:creddinv_task/features/auth/presentation/widgets/logout_button.dart';
import 'package:creddinv_task/features/products/bloc/product_bloc.dart';
import 'package:creddinv_task/features/products/presentation/widgets/catalog_status_message.dart';
import 'package:creddinv_task/features/products/presentation/widgets/product_list.dart';
import 'package:creddinv_task/shared/widgets/cart_badge_button.dart';

class ProductListingScreen extends StatelessWidget {
  const ProductListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          'Creddinv',
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
          ),
        ),
        actions: const [CartBadgeButton(), LogoutButton()],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return switch (state) {
            ProductLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            ProductFailure(:final message) => CatalogStatusMessage(
              message: message,
              onRetry: () {
                context.read<ProductBloc>().add(const ProductsRequested());
              },
            ),
            ProductLoaded(:final products) when products.isEmpty =>
              const CatalogStatusMessage(message: AppStrings.emptyCatalog),
            ProductLoaded(:final products) => ProductList(products: products),
          };
        },
      ),
    );
  }
}
