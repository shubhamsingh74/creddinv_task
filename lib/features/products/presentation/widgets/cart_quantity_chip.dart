import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';

class CartQuantityChip extends StatelessWidget {
  const CartQuantityChip({required this.quantity, super.key});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    if (quantity <= 0) return const SizedBox.shrink();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Text(
          quantity == 1 ? '1 in cart' : '$quantity in cart',
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            height: 1.1,
            color: AppColors.ink,
          ),
        ),
      ),
    );
  }
}
