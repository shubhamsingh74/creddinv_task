import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_gradients.dart';
import 'package:creddinv_task/features/checkout/data/payment_method.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    required this.method,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon = switch (method) {
      PaymentMethod.card => Icons.credit_card,
      PaymentMethod.upi => Icons.account_balance_outlined,
      PaymentMethod.cashOnDelivery => Icons.local_shipping_outlined,
    };
    final detail = switch (method) {
      PaymentMethod.card => 'Visa, Mastercard, and RuPay',
      PaymentMethod.upi => 'Pay with a UPI id',
      PaymentMethod.cashOnDelivery => 'Pay when the order arrives',
    };

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          decoration: BoxDecoration(
            gradient: selected ? AppGradients.ink : null,
            color: selected ? null : AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: selected ? null : Border.all(color: AppColors.line),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: selected ? Colors.white : AppColors.ink,
                  size: 22.r,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        method.label,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: selected ? Colors.white : AppColors.ink,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        detail,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: selected
                              ? Colors.white.withValues(alpha: 0.8)
                              : AppColors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                if (selected)
                  Icon(Icons.check_circle, color: Colors.white, size: 18.r),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
