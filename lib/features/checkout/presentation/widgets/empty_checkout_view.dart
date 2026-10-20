import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/shared/widgets/primary_button.dart';

class EmptyCheckoutView extends StatelessWidget {
  const EmptyCheckoutView({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your cart is empty',
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          PrimaryButton(label: 'Back to shop', onPressed: onBack),
        ],
      ),
    );
  }
}
