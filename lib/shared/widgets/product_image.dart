import 'package:flutter/material.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({required this.assetPath, super.key});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Image.asset(
          assetPath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          cacheWidth: _cacheWidth(context, constraints.maxWidth),
          errorBuilder: (context, error, stackTrace) {
            return const ColoredBox(
              color: AppColors.line,
              child: Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.inkMuted,
                ),
              ),
            );
          },
        );
      },
    );
  }

  int? _cacheWidth(BuildContext context, double logicalWidth) {
    if (!logicalWidth.isFinite || logicalWidth <= 0) return null;
    final pixels = logicalWidth * MediaQuery.devicePixelRatioOf(context);
    return pixels.round().clamp(1, 1600).toInt();
  }
}
