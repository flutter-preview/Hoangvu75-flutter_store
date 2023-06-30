import 'dart:collection';

import 'package:hitek_test/data/models/product.dart';

import '../ibase_repository.dart';

abstract class IProductRepository extends IBaseRepository {
  Future<List<Product>> getProduct(String fields, int limit, int page);
}