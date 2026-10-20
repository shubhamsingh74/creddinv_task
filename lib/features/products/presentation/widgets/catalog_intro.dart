import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/features/products/presentation/widgets/catalog_header.dart';
import 'package:creddinv_task/features/products/presentation/widgets/catalog_search_field.dart';
import 'package:creddinv_task/features/products/presentation/widgets/category_filter_bar.dart';

class CatalogIntro extends StatelessWidget {
  const CatalogIntro({
    required this.count,
    required this.categories,
    super.key,
  });

  final int count;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CatalogHeader(count: count),
          SizedBox(height: 14.h),
          const CatalogSearchField(),
          SizedBox(height: 12.h),
          CategoryFilterBar(categories: categories),
        ],
      ),
    );
  }
}
