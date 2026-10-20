import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:creddinv_task/data/models/product.dart';
import 'package:creddinv_task/data/repositories/local_product_repository.dart';
import 'package:creddinv_task/data/repositories/product_repository.dart';
import 'package:creddinv_task/features/products/bloc/product_bloc.dart';

void main() {
  blocTest<ProductBloc, ProductState>(
    'loads the local catalog',
    build: () => ProductBloc(productRepository: const LocalProductRepository()),
    act: (bloc) => bloc.add(const ProductsRequested()),
    expect: () => [
      isA<ProductLoaded>().having(
        (state) => state.products,
        'products',
        hasLength(12),
      ),
    ],
  );

  blocTest<ProductBloc, ProductState>(
    'surfaces a failure when the repository throws',
    build: () => ProductBloc(productRepository: const _FailingProducts()),
    act: (bloc) => bloc.add(const ProductsRequested()),
    expect: () => [const ProductFailure('Products could not be loaded.')],
  );
}

class _FailingProducts implements ProductRepository {
  const _FailingProducts();

  @override
  Future<List<Product>> fetchProducts() async {
    throw Exception('disk');
  }
}
