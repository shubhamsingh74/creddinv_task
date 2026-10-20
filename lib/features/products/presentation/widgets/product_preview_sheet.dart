import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/core/utils/price_formatter.dart';
import 'package:creddinv_task/data/models/product.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';
import 'package:creddinv_task/features/products/presentation/widgets/add_to_cart_button.dart';
import 'package:creddinv_task/features/products/presentation/widgets/product_preview_media.dart';
import 'package:creddinv_task/features/products/presentation/widgets/product_spec_row.dart';

class ProductPreviewSheet extends StatelessWidget {
  const ProductPreviewSheet({required this.product, super.key});

  final Product product;

  static Future<void> show(BuildContext context, Product product) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => ProductPreviewSheet(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartBloc, CartState, int>(
      selector: (state) => state.quantityOf(product.id),
      builder: (context, quantity) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProductPreviewMedia(product: product),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category.toUpperCase(),
                      style: AppTextStyles.overline,
                    ),
                    SizedBox(height: 6.h),
                    Text(product.name, style: AppTextStyles.title),
                    SizedBox(height: 8.h),
                    Text(product.description, style: AppTextStyles.body),
                    SizedBox(height: 14.h),
                    ProductSpecRow(label: 'Fabric', value: product.fabric),
                    ProductSpecRow(label: 'Fit', value: product.fit),
                    SizedBox(height: 8.h),
                    Text(
                      PriceFormatter.formatCents(product.priceInCents),
                      style: AppTextStyles.price,
                    ),
                    SizedBox(height: 16.h),
                    AddToCartButton(product: product, quantity: quantity),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
