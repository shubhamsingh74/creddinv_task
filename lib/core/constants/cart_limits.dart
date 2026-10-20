/// Bounds for a single cart line. The bloc enforces these, not only the UI.
abstract final class CartLimits {
  static const minQuantity = 1;
  static const maxQuantity = 99;
}
