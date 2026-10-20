import 'package:creddinv_task/data/models/product.dart';

abstract interface class ProductRepository {
  Future<List<Product>> fetchProducts();
}
