import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';

class CheckoutPanelHeader extends StatelessWidget {
  const CheckoutPanelHeader({
    required this.icon,
    required this.title,
    super.key,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28.r,
          height: 28.r,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.accentSoft,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16.r, color: AppColors.ink),
        ),
        SizedBox(width: 8.w),
        Text(title.toUpperCase(), style: AppTextStyles.overline),
      ],
    );
  }
}
