import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/core/utils/price_formatter.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';
import 'package:creddinv_task/features/checkout/bloc/checkout_draft.dart';
import 'package:creddinv_task/features/checkout/data/payment_method.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_line_item.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_panel_header.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_section_card.dart';

class CheckoutReview extends StatelessWidget {
  const CheckoutReview({required this.draft, required this.cart, super.key});

  final CheckoutDraft draft;
  final CartState cart;

  @override
  Widget build(BuildContext context) {
    final payment = switch (draft.method) {
      PaymentMethod.card => _maskedCard(draft.cardNumber),
      PaymentMethod.upi => draft.upiId.trim(),
      PaymentMethod.cashOnDelivery => 'Pay when the order arrives',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CheckoutSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CheckoutPanelHeader(
                icon: Icons.location_on_outlined,
                title: 'Deliver to',
              ),
              SizedBox(height: 12.h),
              Text(draft.name.trim(), style: AppTextStyles.productName),
              SizedBox(height: 2.h),
              Text(draft.phone.trim(), style: AppTextStyles.body),
              SizedBox(height: 2.h),
              Text(draft.address.trim(), style: AppTextStyles.body),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        CheckoutSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CheckoutPanelHeader(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Pay with',
              ),
              SizedBox(height: 12.h),
              Text(draft.method.label, style: AppTextStyles.productName),
              SizedBox(height: 2.h),
              Text(payment, style: AppTextStyles.body),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        CheckoutSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CheckoutPanelHeader(
                icon: Icons.shopping_bag_outlined,
                title: 'Your pieces',
              ),
              SizedBox(height: 14.h),
              for (var index = 0; index < cart.items.length; index++) ...[
                if (index > 0) SizedBox(height: 12.h),
                CheckoutLineItem(item: cart.items[index]),
              ],
              SizedBox(height: 14.h),
              const Divider(height: 1, color: AppColors.line),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Text(cart.quantityLabel, style: AppTextStyles.body),
                  const Spacer(),
                  Text(
                    PriceFormatter.formatCents(cart.totalInCents),
                    style: AppTextStyles.title,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _maskedCard(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 4) return 'Card';
    return 'Card •••• ${digits.substring(digits.length - 4)}';
  }
}
