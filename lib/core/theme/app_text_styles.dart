import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';

/// Text styles scaled with ScreenUtil. Call these from `build` methods.
abstract final class AppTextStyles {
  static TextStyle get headline => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -0.8,
    color: AppColors.ink,
  );

  static TextStyle get title => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.4,
    color: AppColors.ink,
  );

  static TextStyle get productName => TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.2,
    color: AppColors.ink,
  );

  static TextStyle get body => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.inkMuted,
  );

  static TextStyle get price => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.1,
    color: AppColors.ink,
  );

  static TextStyle get overline => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    color: AppColors.inkMuted,
  );
}
