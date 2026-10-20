import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_gradients.dart';

class CheckoutStepMark extends StatelessWidget {
  const CheckoutStepMark({
    required this.number,
    required this.label,
    required this.done,
    required this.active,
    super.key,
  });

  final String number;
  final String label;
  final bool done;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final filled = done || active;
    return SizedBox(
      width: 72.w,
      child: Column(
        children: [
          Container(
            width: 28.r,
            height: 28.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: filled ? AppGradients.ink : null,
              color: filled ? null : AppColors.surface,
              border: filled ? null : Border.all(color: AppColors.line),
            ),
            child: done
                ? Icon(Icons.check, size: 14.r, color: Colors.white)
                : Text(
                    number,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: filled ? Colors.white : AppColors.inkMuted,
                    ),
                  ),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              color: filled ? AppColors.ink : AppColors.inkMuted,
            ),
          ),
        ],
      ),
    );
  }
}
