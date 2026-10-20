part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  bool? get stringify => true;
}

final class ProductLoading extends ProductState {
  const ProductLoading();

  @override
  List<Object?> get props => [];
}

final class ProductLoaded extends ProductState {
  const ProductLoaded(this.products);

  final List<Product> products;

  @override
  List<Object?> get props => [products];
}

final class ProductFailure extends ProductState {
  const ProductFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
