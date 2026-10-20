import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_gradients.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height,
    this.fontSize,
    this.radius,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? height;
  final double? fontSize;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    final showFill = enabled || isLoading;
    final corner = radius ?? 14.r;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: showFill ? AppGradients.ink : null,
        color: showFill ? null : AppColors.line,
        borderRadius: BorderRadius.circular(corner),
      ),
      child: SizedBox(
        width: double.infinity,
        height: height ?? 52.h,
        child: FilledButton(
          onPressed: enabled ? onPressed : null,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            disabledForegroundColor: isLoading
                ? Colors.white
                : AppColors.inkMuted,
            shadowColor: Colors.transparent,
            elevation: 0,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(corner),
            ),
            textStyle: TextStyle(
              fontSize: fontSize ?? 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: 22.r,
                  height: 22.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: Colors.white,
                    semanticsLabel: 'Loading',
                  ),
                )
              : Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
