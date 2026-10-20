import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/features/products/bloc/saved_bloc.dart';

class SaveProductButton extends StatelessWidget {
  const SaveProductButton({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SavedBloc, SavedState, bool>(
      selector: (state) => state.contains(productId),
      builder: (context, saved) {
        return IconButton(
          tooltip: saved ? 'Remove from saved' : 'Save piece',
          onPressed: () {
            context.read<SavedBloc>().add(SavedToggled(productId));
          },
          style: IconButton.styleFrom(
            backgroundColor: const Color(0x66000000),
            foregroundColor: Colors.white,
            minimumSize: Size(32.r, 32.r),
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: Icon(
            saved ? Icons.favorite : Icons.favorite_border,
            size: 18.r,
          ),
        );
      },
    );
  }
}
