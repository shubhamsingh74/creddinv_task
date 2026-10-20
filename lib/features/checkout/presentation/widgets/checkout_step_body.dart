import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';
import 'package:creddinv_task/features/checkout/bloc/checkout_bloc.dart';
import 'package:creddinv_task/features/checkout/data/payment_method.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/card_payment_form.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_review.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/delivery_details_form.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/payment_method_picker.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/upi_payment_form.dart';

class CheckoutStepBody extends StatelessWidget {
  const CheckoutStepBody({
    required this.checkout,
    required this.cart,
    required this.name,
    required this.phone,
    required this.address,
    required this.card,
    required this.expiry,
    required this.cvv,
    required this.upi,
    required this.onChanged,
    required this.onMethod,
    required this.showErrors,
    super.key,
  });

  final CheckoutState checkout;
  final CartState cart;
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController address;
  final TextEditingController card;
  final TextEditingController expiry;
  final TextEditingController cvv;
  final TextEditingController upi;
  final VoidCallback onChanged;
  final ValueChanged<PaymentMethod> onMethod;
  final bool showErrors;

  @override
  Widget build(BuildContext context) {
    return switch (checkout.step) {
      CheckoutStep.details => DeliveryDetailsForm(
        nameController: name,
        phoneController: phone,
        addressController: address,
        onChanged: onChanged,
        showErrors: showErrors,
      ),
      CheckoutStep.payment => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PaymentMethodPicker(
            selected: checkout.draft.method,
            onSelected: onMethod,
          ),
          SizedBox(height: 18.h),
          if (checkout.draft.method == PaymentMethod.card)
            CardPaymentForm(
              numberController: card,
              expiryController: expiry,
              cvvController: cvv,
              onChanged: onChanged,
              showErrors: showErrors,
            ),
          if (checkout.draft.method == PaymentMethod.upi)
            UpiPaymentForm(
              controller: upi,
              onChanged: onChanged,
              showErrors: showErrors,
            ),
          if (checkout.draft.method == PaymentMethod.cashOnDelivery) ...[
            SizedBox(height: 4.h),
            Text(
              'Nothing is charged now. You pay when the order arrives.',
              style: AppTextStyles.body,
            ),
          ],
        ],
      ),
      CheckoutStep.review || CheckoutStep.complete => CheckoutReview(
        draft: checkout.draft,
        cart: cart,
      ),
    };
  }
}
