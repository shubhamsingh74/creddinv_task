import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/features/products/presentation/widgets/catalog_sort_button.dart';

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('New arrivals', style: AppTextStyles.headline),
              SizedBox(height: 6.h),
              Text(
                '$count pieces. Add any of them to your cart.',
                style: AppTextStyles.body,
              ),
            ],
          ),
        ),
        const CatalogSortButton(),
      ],
    );
  }
}
