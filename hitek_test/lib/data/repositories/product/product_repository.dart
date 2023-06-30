import 'package:hitek_test/data/models/base_response.dart';
import 'package:hitek_test/data/models/product.dart';

import '../../common/base_service.dart';
import 'iproduct_repository.dart';

class ProductRepository extends IProductRepository {
  ProductRepository({
    required BaseService api,
  }) : _api = api;
  final BaseService _api;

  @override
  Future<List<Product>> getProduct(String fields, int limit, int page) async {
    Map<String, dynamic> queries = {
      "fields": fields,
      "limit": limit,
      "page": page,
    };
    BaseResponse<dynamic> response = await _api.client.getProduct(queries);
    return response.parseList((map) => Product.fromJson(map));
  }
}
