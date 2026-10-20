import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_gradients.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/core/utils/price_formatter.dart';
import 'package:creddinv_task/data/models/product.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';
import 'package:creddinv_task/features/products/presentation/widgets/add_to_cart_button.dart';
import 'package:creddinv_task/features/products/presentation/widgets/cart_quantity_chip.dart';
import 'package:creddinv_task/features/products/presentation/widgets/product_preview_sheet.dart';
import 'package:creddinv_task/features/products/presentation/widgets/save_product_button.dart';
import 'package:creddinv_task/shared/widgets/fixed_line_box.dart';
import 'package:creddinv_task/shared/widgets/product_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartBloc, CartState, int>(
      selector: (state) => state.quantityOf(product.id),
      builder: (context, quantity) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => ProductPreviewSheet.show(context, product),
                  child: AspectRatio(
                    aspectRatio: 4 / 5,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ProductImage(assetPath: product.imageAsset),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: AppGradients.scrim,
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: SaveProductButton(productId: product.id),
                        ),
                        if (quantity > 0)
                          Positioned(
                            left: 8.w,
                            bottom: 8.h,
                            child: CartQuantityChip(quantity: quantity),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FixedLineBox(
                        lines: 1,
                        style: AppTextStyles.overline.copyWith(height: 1.2),
                        child: Text(
                          product.category.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.overline.copyWith(height: 1.2),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      FixedLineBox(
                        lines: 2,
                        style: AppTextStyles.productName,
                        child: Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.productName,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      FixedLineBox(
                        lines: 1,
                        style: AppTextStyles.body.copyWith(height: 1.3),
                        child: Text(
                          product.fabric,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body.copyWith(height: 1.3),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        PriceFormatter.formatCents(product.priceInCents),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.price.copyWith(height: 1.2),
                      ),
                      SizedBox(height: 10.h),
                      AddToCartButton(product: product, quantity: quantity),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
