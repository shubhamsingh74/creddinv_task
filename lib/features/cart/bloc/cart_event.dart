part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

final class CartItemAdded extends CartEvent {
  const CartItemAdded(this.product);

  final Product product;

  @override
  List<Object?> get props => [product];
}

final class CartQuantityIncreased extends CartEvent {
  const CartQuantityIncreased(this.productId);

  final String productId;

  @override
  List<Object?> get props => [productId];
}

final class CartQuantityDecreased extends CartEvent {
  const CartQuantityDecreased(this.productId);

  final String productId;

  @override
  List<Object?> get props => [productId];
}

final class CartItemRemoved extends CartEvent {
  const CartItemRemoved(this.productId);

  final String productId;

  @override
  List<Object?> get props => [productId];
}

final class CartCleared extends CartEvent {
  const CartCleared();
}
