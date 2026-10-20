import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:creddinv_task/core/router/app_routes.dart';
import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';

class CartBadgeButton extends StatelessWidget {
  const CartBadgeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
          previous.totalQuantity != current.totalQuantity,
      builder: (context, state) {
        return IconButton(
          tooltip: 'Open cart',
          onPressed: () => context.push(AppRoutes.cart),
          icon: Badge(
            isLabelVisible: state.totalQuantity > 0,
            backgroundColor: AppColors.ink,
            textColor: Colors.white,
            label: Text('${state.totalQuantity}'),
            child: const Icon(Icons.shopping_bag_outlined),
          ),
        );
      },
    );
  }
}
