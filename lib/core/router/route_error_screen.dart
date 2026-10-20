import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:creddinv_task/core/constants/app_strings.dart';
import 'package:creddinv_task/core/router/app_routes.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/shared/widgets/app_scaffold.dart';
import 'package:creddinv_task/shared/widgets/primary_button.dart';
import 'package:creddinv_task/shared/widgets/status_icon.dart';

class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const StatusIcon(icon: Icons.search_off_outlined),
              SizedBox(height: 16.h),
              Text(
                AppStrings.routeNotFound,
                style: AppTextStyles.title,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              PrimaryButton(
                label: AppStrings.backToShop,
                onPressed: () => context.go(AppRoutes.products),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
