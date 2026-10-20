import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/core/utils/price_formatter.dart';
import 'package:creddinv_task/data/models/cart_item.dart';
import 'package:creddinv_task/shared/widgets/product_image.dart';

class CheckoutLineItem extends StatelessWidget {
  const CheckoutLineItem({required this.item, super.key});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final quantity = item.quantity == 1 ? 'Qty 1' : 'Qty ${item.quantity}';
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: SizedBox(
            width: 52.w,
            height: 64.h,
            child: ProductImage(assetPath: item.product.imageAsset),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.productName,
              ),
              SizedBox(height: 2.h),
              Text(quantity, style: AppTextStyles.body),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          PriceFormatter.formatCents(item.lineTotalInCents),
          style: AppTextStyles.price.copyWith(color: AppColors.ink),
        ),
      ],
    );
  }
}
