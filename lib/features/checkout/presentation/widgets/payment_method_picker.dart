import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/features/checkout/data/payment_method.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/payment_method_tile.dart';

class PaymentMethodPicker extends StatelessWidget {
  const PaymentMethodPicker({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final PaymentMethod selected;
  final ValueChanged<PaymentMethod> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final method in PaymentMethod.values) ...[
          PaymentMethodTile(
            method: method,
            selected: method == selected,
            onTap: () => onSelected(method),
          ),
          if (method != PaymentMethod.values.last) SizedBox(height: 10.h),
        ],
      ],
    );
  }
}
