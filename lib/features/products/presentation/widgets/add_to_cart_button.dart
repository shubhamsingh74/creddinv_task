import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/constants/app_strings.dart';
import 'package:creddinv_task/core/constants/cart_limits.dart';
import 'package:creddinv_task/data/models/product.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';
import 'package:creddinv_task/shared/widgets/gradient_button.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    required this.product,
    required this.quantity,
    super.key,
  });

  final Product product;
  final int quantity;

  void _add(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    if (quantity >= CartLimits.maxQuantity) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'You can add up to ${CartLimits.maxQuantity} of this item.',
            ),
          ),
        );
      return;
    }

    unawaited(HapticFeedback.lightImpact());
    context.read<CartBloc>().add(CartItemAdded(product));
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(AppStrings.addedToCart),
          duration: Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      label: 'Add to cart',
      height: 36.h,
      fontSize: 12.sp,
      radius: 10.r,
      onPressed: () => _add(context),
    );
  }
}
