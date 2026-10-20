import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:creddinv_task/core/router/app_routes.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';
import 'package:creddinv_task/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:creddinv_task/features/cart/presentation/widgets/cart_total_bar.dart';
import 'package:creddinv_task/features/cart/presentation/widgets/empty_cart_view.dart';
import 'package:creddinv_task/shared/widgets/app_scaffold.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _browse(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.products);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.isEmpty) {
            return EmptyCartView(onBrowse: () => _browse(context));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
                  itemCount: state.items.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return CartItemTile(
                      key: ValueKey(item.product.id),
                      item: item,
                    );
                  },
                ),
              ),
              CartTotalBar(state: state),
            ],
          );
        },
      ),
    );
  }
}
