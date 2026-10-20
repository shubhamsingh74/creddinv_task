import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:creddinv_task/core/constants/cart_limits.dart';
import 'package:creddinv_task/data/models/cart_item.dart';
import 'package:creddinv_task/data/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

/// In-memory cart. Provided above the router so it survives screen changes.
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onAdded);
    on<CartQuantityIncreased>(_onIncreased);
    on<CartQuantityDecreased>(_onDecreased);
    on<CartItemRemoved>(_onRemoved);
    on<CartCleared>(_onCleared);
  }

  void _onAdded(CartItemAdded event, Emitter<CartState> emit) {
    final items = [...state.items];
    final index = items.indexWhere(
      (item) => item.product.id == event.product.id,
    );
    if (index == -1) {
      items.add(
        CartItem(product: event.product, quantity: CartLimits.minQuantity),
      );
    } else {
      final current = items[index];
      if (current.quantity >= CartLimits.maxQuantity) return;
      items[index] = current.copyWith(quantity: current.quantity + 1);
    }
    emit(CartState(items: List.unmodifiable(items)));
  }

  void _onIncreased(CartQuantityIncreased event, Emitter<CartState> emit) {
    final index = state.items.indexWhere(
      (item) => item.product.id == event.productId,
    );
    if (index == -1) return;

    final current = state.items[index];
    if (current.quantity >= CartLimits.maxQuantity) return;

    final items = [...state.items];
    items[index] = current.copyWith(quantity: current.quantity + 1);
    emit(CartState(items: List.unmodifiable(items)));
  }

  void _onDecreased(CartQuantityDecreased event, Emitter<CartState> emit) {
    final index = state.items.indexWhere(
      (item) => item.product.id == event.productId,
    );
    if (index == -1) return;

    final current = state.items[index];
    if (current.quantity <= CartLimits.minQuantity) return;

    final items = [...state.items];
    items[index] = current.copyWith(quantity: current.quantity - 1);
    emit(CartState(items: List.unmodifiable(items)));
  }

  void _onRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final items = state.items
        .where((item) => item.product.id != event.productId)
        .toList(growable: false);
    emit(CartState(items: items));
  }

  void _onCleared(CartCleared event, Emitter<CartState> emit) {
    emit(const CartState());
  }
}
