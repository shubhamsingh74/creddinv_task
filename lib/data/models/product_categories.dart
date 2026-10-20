import 'package:creddinv_task/data/models/product.dart';

/// First-seen category order, so the filter bar stays stable as the catalog grows.
abstract final class ProductCategories {
  static List<String> distinct(Iterable<Product> products) {
    final seen = <String>[];
    for (final product in products) {
      if (!seen.contains(product.category)) seen.add(product.category);
    }
    return seen;
  }
}
