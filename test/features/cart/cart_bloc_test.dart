import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:creddinv_task/core/constants/cart_limits.dart';
import 'package:creddinv_task/data/models/cart_item.dart';
import 'package:creddinv_task/data/models/product.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';

const _shirt = Product(
  id: 'shirt',
  name: 'Shirt',
  description: 'A shirt',
  priceInCents: 5000,
  imageAsset: 'assets/images/oxford_shirt.jpg',
  category: 'Tops',
  fabric: 'Cotton',
  fit: 'Regular',
);

const _tote = Product(
  id: 'tote',
  name: 'Tote',
  description: 'A tote',
  priceInCents: 2000,
  imageAsset: 'assets/images/canvas_tote.jpg',
  category: 'Accessories',
  fabric: 'Canvas',
  fit: 'Structured',
);

void main() {
  blocTest<CartBloc, CartState>(
    'adds a product and increments it when added again',
    build: CartBloc.new,
    act: (bloc) => bloc
      ..add(const CartItemAdded(_shirt))
      ..add(const CartItemAdded(_shirt)),
    verify: (bloc) {
      expect(bloc.state.quantityOf('shirt'), 2);
      expect(bloc.state.totalQuantity, 2);
      expect(bloc.state.totalInCents, 10000);
    },
  );

  blocTest<CartBloc, CartState>(
    'totals mixed products',
    build: CartBloc.new,
    act: (bloc) => bloc
      ..add(const CartItemAdded(_shirt))
      ..add(const CartItemAdded(_tote)),
    verify: (bloc) {
      expect(bloc.state.totalQuantity, 2);
      expect(bloc.state.totalInCents, 7000);
      expect(bloc.state.quantityLabel, '2 items');
    },
  );

  blocTest<CartBloc, CartState>(
    'does not drop quantity below 1',
    build: CartBloc.new,
    seed: () =>
        const CartState(items: [CartItem(product: _shirt, quantity: 1)]),
    act: (bloc) => bloc.add(const CartQuantityDecreased('shirt')),
    expect: () => const <CartState>[],
  );

  blocTest<CartBloc, CartState>(
    'decreases quantity above 1',
    build: CartBloc.new,
    seed: () =>
        const CartState(items: [CartItem(product: _shirt, quantity: 3)]),
    act: (bloc) => bloc.add(const CartQuantityDecreased('shirt')),
    verify: (bloc) {
      expect(bloc.state.quantityOf('shirt'), 2);
      expect(bloc.state.totalInCents, 10000);
    },
  );

  blocTest<CartBloc, CartState>(
    'removes a product',
    build: CartBloc.new,
    seed: () => const CartState(
      items: [
        CartItem(product: _shirt, quantity: 1),
        CartItem(product: _tote, quantity: 2),
      ],
    ),
    act: (bloc) => bloc.add(const CartItemRemoved('shirt')),
    verify: (bloc) {
      expect(bloc.state.quantityOf('shirt'), 0);
      expect(bloc.state.totalInCents, 4000);
      expect(bloc.state.isEmpty, isFalse);
    },
  );

  blocTest<CartBloc, CartState>(
    'clears the cart',
    build: CartBloc.new,
    seed: () => const CartState(items: [CartItem(product: _tote, quantity: 1)]),
    act: (bloc) => bloc.add(const CartCleared()),
    expect: () => [const CartState()],
  );

  blocTest<CartBloc, CartState>(
    'does not raise quantity above the cap',
    build: CartBloc.new,
    seed: () => const CartState(
      items: [CartItem(product: _shirt, quantity: CartLimits.maxQuantity)],
    ),
    act: (bloc) => bloc
      ..add(const CartItemAdded(_shirt))
      ..add(const CartQuantityIncreased('shirt')),
    expect: () => const <CartState>[],
  );
}
