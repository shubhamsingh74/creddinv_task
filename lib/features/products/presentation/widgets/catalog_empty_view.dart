import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/features/products/bloc/catalog_bloc.dart';

class CatalogEmptyView extends StatelessWidget {
  const CatalogEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.h),
      child: Column(
        children: [
          Text(
            'No pieces match',
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Try another word, or clear the filters.',
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          TextButton(
            onPressed: () {
              context.read<CatalogBloc>().add(const CatalogReset());
            },
            child: const Text('Clear filters'),
          ),
        ],
      ),
    );
  }
}
