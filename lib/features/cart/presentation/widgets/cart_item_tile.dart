import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/constants/cart_limits.dart';
import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/core/utils/price_formatter.dart';
import 'package:creddinv_task/data/models/cart_item.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';
import 'package:creddinv_task/features/cart/presentation/widgets/quantity_stepper.dart';
import 'package:creddinv_task/shared/widgets/product_image.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({required this.item, super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: const BorderSide(color: AppColors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: SizedBox(
                width: 88.w,
                height: 112.h,
                child: ProductImage(assetPath: product.imageAsset),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 15.sp * 1.25 * 2,
                          child: Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.productName,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Remove item',
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints.tight(Size(32.r, 32.r)),
                        onPressed: () {
                          context.read<CartBloc>().add(
                            CartItemRemoved(product.id),
                          );
                        },
                        icon: Icon(
                          Icons.close,
                          size: 18.r,
                          color: AppColors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    product.category.toUpperCase(),
                    style: AppTextStyles.overline,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    PriceFormatter.formatCents(product.priceInCents),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.price.copyWith(height: 1.2),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 13.sp * 1.45,
                    child: item.quantity > 1
                        ? Text(
                            '${PriceFormatter.formatCents(item.lineTotalInCents)} line total',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.body,
                          )
                        : null,
                  ),
                  SizedBox(height: 12.h),
                  QuantityStepper(
                    quantity: item.quantity,
                    onIncrement: () {
                      context.read<CartBloc>().add(
                        CartQuantityIncreased(product.id),
                      );
                    },
                    onDecrement: item.quantity > CartLimits.minQuantity
                        ? () {
                            context.read<CartBloc>().add(
                              CartQuantityDecreased(product.id),
                            );
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
