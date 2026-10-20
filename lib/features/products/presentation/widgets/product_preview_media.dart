import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_gradients.dart';
import 'package:creddinv_task/data/models/product.dart';
import 'package:creddinv_task/features/products/presentation/widgets/save_product_button.dart';
import 'package:creddinv_task/shared/widgets/product_image.dart';

class ProductPreviewMedia extends StatelessWidget {
  const ProductPreviewMedia({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      child: SizedBox(
        height: 280.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ProductImage(assetPath: product.imageAsset),
            const DecoratedBox(
              decoration: BoxDecoration(gradient: AppGradients.scrim),
            ),
            Positioned(
              top: 12.h,
              right: 12.w,
              child: SaveProductButton(productId: product.id),
            ),
          ],
        ),
      ),
    );
  }
}
