import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/features/checkout/bloc/checkout_bloc.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_step_mark.dart';

class CheckoutStepHeader extends StatelessWidget {
  const CheckoutStepHeader({required this.step, super.key});

  final CheckoutStep step;

  @override
  Widget build(BuildContext context) {
    final active = switch (step) {
      CheckoutStep.details => 0,
      CheckoutStep.payment => 1,
      CheckoutStep.review || CheckoutStep.complete => 2,
    };
    final copy = switch (step) {
      CheckoutStep.details => ('Delivery', 'Where should these pieces arrive?'),
      CheckoutStep.payment => ('Payment', 'Card, UPI, or cash on delivery.'),
      CheckoutStep.review || CheckoutStep.complete => (
        'Review',
        'Confirm the details, then place the order.',
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(copy.$1, style: AppTextStyles.title),
        SizedBox(height: 4.h),
        Text(copy.$2, style: AppTextStyles.body),
        SizedBox(height: 18.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var index = 0; index < _labels.length; index++) ...[
              CheckoutStepMark(
                number: '${index + 1}',
                label: _labels[index],
                done: index < active,
                active: index == active,
              ),
              if (index < _labels.length - 1)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 13.r),
                    child: Container(
                      height: 2,
                      color: index < active ? AppColors.ink : AppColors.line,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ],
    );
  }
}

const _labels = ['Delivery', 'Payment', 'Review'];
