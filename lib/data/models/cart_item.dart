import 'package:equatable/equatable.dart';

import 'package:creddinv_task/data/models/product.dart';

class CartItem extends Equatable {
  const CartItem({required this.product, required this.quantity})
    : assert(quantity > 0, 'Quantity must be at least 1');

  final Product product;
  final int quantity;

  int get lineTotalInCents => product.priceInCents * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }

  @override
  List<Object?> get props => [product, quantity];
}
