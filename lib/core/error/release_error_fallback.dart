import 'package:flutter/material.dart';

import 'package:creddinv_task/core/constants/app_strings.dart';
import 'package:creddinv_task/core/theme/app_colors.dart';

/// Shown in release when a widget fails to build. Debug keeps the red screen.
class ReleaseErrorFallback extends StatelessWidget {
  const ReleaseErrorFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: ColoredBox(
        color: AppColors.background,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              AppStrings.releaseError,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
