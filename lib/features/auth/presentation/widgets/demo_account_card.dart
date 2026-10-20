import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/constants/demo_credentials.dart';
import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';

class DemoAccountCard extends StatelessWidget {
  const DemoAccountCard({required this.onFill, super.key});

  final VoidCallback onFill;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.line),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DEMO ACCOUNT', style: AppTextStyles.overline),
            SizedBox(height: 10.h),
            SelectableText(
              DemoCredentials.email,
              style: AppTextStyles.productName,
            ),
            SizedBox(height: 2.h),
            SelectableText(DemoCredentials.password, style: AppTextStyles.body),
            SizedBox(height: 8.h),
            Text(
              'Checked on this device. Nothing is sent to a server.',
              style: AppTextStyles.body,
            ),
            SizedBox(height: 12.h),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.ink,
                backgroundColor: AppColors.accentSoft,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: onFill,
              child: Text(
                'Use demo account',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
