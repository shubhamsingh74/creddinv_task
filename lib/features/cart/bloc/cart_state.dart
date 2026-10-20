part of 'cart_bloc.dart';

final class CartState extends Equatable {
  const CartState({this.items = const []});

  final List<CartItem> items;

  bool get isEmpty => items.isEmpty;

  int get totalQuantity =>
      items.fold<int>(0, (sum, item) => sum + item.quantity);

  int get totalInCents =>
      items.fold<int>(0, (sum, item) => sum + item.lineTotalInCents);

  int quantityOf(String productId) {
    for (final item in items) {
      if (item.product.id == productId) return item.quantity;
    }
    return 0;
  }

  String get quantityLabel =>
      totalQuantity == 1 ? '1 item' : '$totalQuantity items';

  @override
  List<Object?> get props => [items];

  @override
  bool? get stringify => true;
}
