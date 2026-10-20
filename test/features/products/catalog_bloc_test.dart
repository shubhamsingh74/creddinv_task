import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:creddinv_task/data/sources/local_product_data.dart';
import 'package:creddinv_task/features/products/bloc/catalog_bloc.dart';

void main() {
  final products = LocalProductData.products;

  blocTest<CatalogBloc, CatalogState>(
    'filters the catalog by name',
    build: CatalogBloc.new,
    act: (bloc) => bloc.add(const CatalogSearchChanged('poncho')),
    verify: (bloc) {
      final visible = bloc.state.apply(products, const {});
      expect(visible.map((product) => product.name), ['Fringe Knit Poncho']);
    },
  );

  blocTest<CatalogBloc, CatalogState>(
    'filters by category and can return to the full shop',
    build: CatalogBloc.new,
    act: (bloc) => bloc
      ..add(const CatalogCategorySelected('Tops'))
      ..add(const CatalogCategorySelected(null)),
    verify: (bloc) {
      expect(bloc.state.apply(products, const {}), hasLength(products.length));
    },
  );

  test('saved-only keeps pieces the shopper marked', () {
    const state = CatalogState(savedOnly: true);
    final visible = state.apply(products, const {'kraft-tote'});
    expect(visible.single.id, 'kraft-tote');
  });

  test('price sort does not change the featured order until asked', () {
    const state = CatalogState(sort: CatalogSort.priceAscending);
    final visible = state.apply(products, const {});
    expect(visible.first.id, 'kraft-tote');
    expect(visible.last.id, 'camel-wrap-coat');
  });

  blocTest<CatalogBloc, CatalogState>(
    'reset clears an active query',
    build: CatalogBloc.new,
    act: (bloc) => bloc
      ..add(const CatalogSearchChanged('coat'))
      ..add(const CatalogReset()),
    expect: () => [const CatalogState(query: 'coat'), const CatalogState()],
  );
}
