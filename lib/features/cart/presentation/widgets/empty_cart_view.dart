import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/shared/widgets/primary_button.dart';
import 'package:creddinv_task/shared/widgets/status_icon.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({required this.onBrowse, super.key});

  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const StatusIcon(icon: Icons.shopping_bag_outlined),
          SizedBox(height: 18.h),
          Text(
            'Your cart is empty',
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Add a piece from the shop and it will stay here while you browse.',
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          PrimaryButton(label: 'Browse products', onPressed: onBrowse),
        ],
      ),
    );
  }
}
