import 'package:creddinv_task/data/models/product.dart';
import 'package:creddinv_task/data/repositories/product_repository.dart';
import 'package:creddinv_task/data/sources/local_product_data.dart';

class LocalProductRepository implements ProductRepository {
  const LocalProductRepository();

  @override
  Future<List<Product>> fetchProducts() async => LocalProductData.products;
}
