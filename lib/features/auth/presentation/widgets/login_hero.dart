import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_gradients.dart';
import 'package:creddinv_task/features/auth/presentation/widgets/brand_mark.dart';

class LoginHero extends StatelessWidget {
  const LoginHero({super.key});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, top + 36.h, 24.w, 64.h),
      decoration: const BoxDecoration(gradient: AppGradients.ink),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BrandMark(onDark: true),
          SizedBox(height: 18.h),
          Text(
            'Clothing, considered.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
