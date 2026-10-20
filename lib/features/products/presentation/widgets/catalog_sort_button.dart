import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:creddinv_task/features/products/bloc/catalog_bloc.dart';

class CatalogSortButton extends StatelessWidget {
  const CatalogSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      buildWhen: (previous, current) => previous.sort != current.sort,
      builder: (context, state) {
        return PopupMenuButton<CatalogSort>(
          tooltip: 'Sort pieces',
          initialValue: state.sort,
          onSelected: (sort) {
            context.read<CatalogBloc>().add(CatalogSortSelected(sort));
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: CatalogSort.featured, child: Text('Featured')),
            PopupMenuItem(
              value: CatalogSort.priceAscending,
              child: Text('Price: low to high'),
            ),
            PopupMenuItem(
              value: CatalogSort.priceDescending,
              child: Text('Price: high to low'),
            ),
          ],
          icon: const Icon(Icons.swap_vert),
        );
      },
    );
  }
}
