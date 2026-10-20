import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';

class QuantityStepButton extends StatelessWidget {
  const QuantityStepButton({
    required this.tooltip,
    required this.onPressed,
    required this.icon,
    super.key,
  });

  final String tooltip;
  final VoidCallback? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints.tight(Size(32.r, 32.r)),
      icon: Icon(
        icon,
        size: 16.r,
        color: onPressed == null ? AppColors.inkMuted : AppColors.ink,
      ),
    );
  }
}
