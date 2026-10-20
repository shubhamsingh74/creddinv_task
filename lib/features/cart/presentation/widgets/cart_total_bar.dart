import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_gradients.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/core/utils/price_formatter.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';
import 'package:creddinv_task/features/cart/presentation/widgets/checkout_button.dart';

class CartTotalBar extends StatelessWidget {
  const CartTotalBar({required this.state, super.key});

  final CartState state;

  @override
  Widget build(BuildContext context) {
    final onGradient = AppTextStyles.body.copyWith(color: Colors.white);
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppGradients.ink),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: AppTextStyles.overline.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(state.quantityLabel, style: onGradient),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    PriceFormatter.formatCents(state.totalInCents),
                    style: AppTextStyles.title.copyWith(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              const CheckoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
