import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/features/products/bloc/catalog_bloc.dart';
import 'package:creddinv_task/features/products/presentation/widgets/category_filter_chip.dart';

class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({required this.categories, super.key});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      buildWhen: (previous, current) =>
          previous.category != current.category ||
          previous.savedOnly != current.savedOnly,
      builder: (context, state) {
        final labels = ['All', ...categories, 'Saved'];
        return SizedBox(
          height: 36.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: labels.length,
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final label = labels[index];
              final selected = _isSelected(label, state);
              return CategoryFilterChip(
                label: label,
                selected: selected,
                onTap: () => _select(context, label),
              );
            },
          ),
        );
      },
    );
  }

  bool _isSelected(String label, CatalogState state) {
    if (label == 'All') return state.category == null && !state.savedOnly;
    if (label == 'Saved') return state.savedOnly;
    return state.category == label;
  }

  void _select(BuildContext context, String label) {
    final bloc = context.read<CatalogBloc>();
    if (label == 'Saved') {
      bloc.add(const CatalogSavedOnlyToggled());
      return;
    }
    if (label == 'All') {
      bloc.add(const CatalogCategorySelected(null));
      return;
    }
    bloc.add(CatalogCategorySelected(label));
  }
}
