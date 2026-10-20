import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/features/products/bloc/catalog_bloc.dart';

class CatalogSearchField extends StatefulWidget {
  const CatalogSearchField({super.key});

  @override
  State<CatalogSearchField> createState() => _CatalogSearchFieldState();
}

class _CatalogSearchFieldState extends State<CatalogSearchField> {
  final _controller = TextEditingController();
  late final CatalogBloc _catalogBloc;
  late final StreamSubscription<CatalogState> _subscription;

  @override
  void initState() {
    super.initState();
    _catalogBloc = context.read<CatalogBloc>();
    _controller.text = _catalogBloc.state.query;
    _subscription = _catalogBloc.stream.listen(_syncQuery);
  }

  void _syncQuery(CatalogState state) {
    if (!mounted || state.query == _controller.text) return;
    _controller.value = TextEditingValue(
      text: state.query,
      selection: TextSelection.collapsed(offset: state.query.length),
    );
  }

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      cursorColor: AppColors.ink,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.ink,
      ),
      decoration: InputDecoration(
        hintText: 'Search pieces',
        hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.inkMuted),
        prefixIcon: Icon(Icons.search, size: 20.r, color: AppColors.inkMuted),
        filled: true,
        fillColor: AppColors.surface,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        border: _border,
        enabledBorder: _border,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.ink, width: 1.2),
        ),
      ),
      onChanged: (value) {
        _catalogBloc.add(CatalogSearchChanged(value));
      },
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14.r),
      borderSide: const BorderSide(color: AppColors.line),
    );
  }
}
