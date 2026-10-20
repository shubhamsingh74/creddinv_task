import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/data/models/product.dart';
import 'package:creddinv_task/data/models/product_categories.dart';
import 'package:creddinv_task/features/products/bloc/catalog_bloc.dart';
import 'package:creddinv_task/features/products/bloc/saved_bloc.dart';
import 'package:creddinv_task/features/products/presentation/widgets/catalog_empty_view.dart';
import 'package:creddinv_task/features/products/presentation/widgets/catalog_intro.dart';
import 'package:creddinv_task/features/products/presentation/widgets/product_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({required this.products, super.key});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, catalog) {
        return BlocBuilder<SavedBloc, SavedState>(
          builder: (context, saved) {
            final visible = catalog.apply(products, saved.ids);
            final rowCount = (visible.length + 1) ~/ 2;
            final itemCount = visible.isEmpty ? 2 : rowCount + 1;

            return ListView.builder(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 28.h),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CatalogIntro(
                    count: visible.length,
                    categories: ProductCategories.distinct(products),
                  );
                }
                if (visible.isEmpty) return const CatalogEmptyView();

                final start = (index - 1) * 2;
                final right = start + 1 < visible.length
                    ? visible[start + 1]
                    : null;

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: ProductCard(product: visible[start])),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: right == null
                              ? const SizedBox.shrink()
                              : ProductCard(product: right),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
