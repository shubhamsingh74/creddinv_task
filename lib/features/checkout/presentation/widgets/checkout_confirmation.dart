import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:creddinv_task/core/router/app_routes.dart';
import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_gradients.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/core/utils/price_formatter.dart';
import 'package:creddinv_task/features/checkout/data/checkout_order.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_receipt_row.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_section_card.dart';
import 'package:creddinv_task/shared/widgets/primary_button.dart';

class CheckoutConfirmation extends StatelessWidget {
  const CheckoutConfirmation({required this.order, super.key});

  final CheckoutOrder order;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final pieces = order.itemCount == 1
        ? '1 piece'
        : '${order.itemCount} pieces';

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(bottom: 8.h),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(24.w, top + 28.h, 24.w, 64.h),
                decoration: const BoxDecoration(gradient: AppGradients.ink),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56.r,
                      height: 56.r,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: AppGradients.bronze,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.ink,
                        size: 28.r,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      'CONFIRMED',
                      style: AppTextStyles.overline.copyWith(
                        color: Colors.white.withValues(alpha: 0.72),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Order placed',
                      style: AppTextStyles.headline.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Thanks, ${order.recipientName}. Your pieces are confirmed.',
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white.withValues(alpha: 0.82),
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(0, -32.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CheckoutSectionCard(
                    child: Column(
                      children: [
                        CheckoutReceiptRow(label: 'Order', value: order.id),
                        SizedBox(height: 14.h),
                        CheckoutReceiptRow(
                          label: 'Payment',
                          value: order.paymentSummary,
                        ),
                        SizedBox(height: 14.h),
                        CheckoutReceiptRow(label: 'Pieces', value: pieces),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          child: const Divider(
                            height: 1,
                            color: AppColors.line,
                          ),
                        ),
                        CheckoutReceiptRow(
                          label: 'Total',
                          value: PriceFormatter.formatCents(order.totalInCents),
                          emphasize: true,
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          'Confirmed on this device. Nothing was sent to a bank.',
                          style: AppTextStyles.body,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.line)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
              child: PrimaryButton(
                label: 'Continue shopping',
                onPressed: () => context.go(AppRoutes.products),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
