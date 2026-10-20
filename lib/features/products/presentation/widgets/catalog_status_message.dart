import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/shared/widgets/primary_button.dart';
import 'package:creddinv_task/shared/widgets/status_icon.dart';

class CatalogStatusMessage extends StatelessWidget {
  const CatalogStatusMessage({required this.message, this.onRetry, super.key});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StatusIcon(
              icon: onRetry == null
                  ? Icons.inventory_2_outlined
                  : Icons.error_outline,
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 20.h),
              PrimaryButton(label: 'Try again', onPressed: onRetry),
            ],
          ],
        ),
      ),
    );
  }
}
