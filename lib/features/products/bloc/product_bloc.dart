import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:creddinv_task/core/constants/app_strings.dart';
import 'package:creddinv_task/data/models/product.dart';
import 'package:creddinv_task/data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required ProductRepository productRepository})
    : _productRepository = productRepository,
      super(const ProductLoading()) {
    on<ProductsRequested>(_onRequested);
  }

  final ProductRepository _productRepository;

  Future<void> _onRequested(
    ProductsRequested event,
    Emitter<ProductState> emit,
  ) async {
    if (state is! ProductLoading) {
      emit(const ProductLoading());
    }
    try {
      final products = await _productRepository.fetchProducts();
      emit(ProductLoaded(products));
    } on Object {
      emit(const ProductFailure(AppStrings.productsLoadFailed));
    }
  }
}
