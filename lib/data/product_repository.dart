import 'package:test_commerce/data/product_services.dart';

import 'model/product_model.dart';

class ProductRepository {
  final ProductServices _services = ProductServices();

  Future<List<ProductModel>> getProduct({int limit = 5}) async =>
      await _services.getProduct(limit);

  Future<List<String>> getCategories() async => await _services.getCategories();
}
