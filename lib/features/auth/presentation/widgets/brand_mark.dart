import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_gradients.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({this.onDark = false, super.key});

  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.r,
          height: 40.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: onDark ? AppGradients.bronze : AppGradients.ink,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            'C',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          'CREDDINV',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.4,
            color: onDark ? Colors.white : AppColors.ink,
          ),
        ),
      ],
    );
  }
}
