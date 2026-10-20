import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/features/checkout/bloc/checkout_bloc.dart';
import 'package:creddinv_task/shared/widgets/primary_button.dart';

class CheckoutActionBar extends StatelessWidget {
  const CheckoutActionBar({
    required this.checkout,
    required this.totalLabel,
    required this.onPressed,
    super.key,
  });

  final CheckoutState checkout;
  final String totalLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final placing = checkout.step == CheckoutStep.review;
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TOTAL', style: AppTextStyles.overline),
                  SizedBox(height: 2.h),
                  Text(totalLabel, style: AppTextStyles.title),
                ],
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: PrimaryButton(
                  label: placing ? 'Place order' : 'Continue',
                  isLoading: checkout.submitting,
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
