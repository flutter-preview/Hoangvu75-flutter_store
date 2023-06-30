import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:hitek_test/common/config/app_constants.dart';
import 'package:hitek_test/data/common/base_service.dart';
import 'package:hitek_test/data/models/product.dart';
import 'package:hitek_test/data/repositories/auth/auth_repository.dart';
import 'package:hitek_test/data/repositories/auth/iauth_repository.dart';
import 'package:hitek_test/data/repositories/product/product_repository.dart';
import 'package:hitek_test/data/service/account_service.dart';
import 'package:hitek_test/utils/validator.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/repositories/product/iproduct_repository.dart';
import '../../utils/dialog_utils.dart';

class StoreController {
  late Stream<dynamic> storeControllerStream;

  late final IProductRepository productRepository;
  int currentPage = 1;
  BehaviorSubject<List<Product>> bsListProduct = BehaviorSubject<List<Product>>.seeded([]);

  StoreController() {
    storeControllerStream = Rx.combineLatestList<dynamic>([
      bsListProduct,
    ]);

    productRepository = ProductRepository(api: BaseService());
  }

  Future<void> onGetProduct() async {
    List<Product> mListProduct = await getProduct();
    List<Product> currentListProduct = bsListProduct.value;
    currentListProduct.addAll(mListProduct);
    bsListProduct.add(currentListProduct);
  }

  Future<List<Product>> getProduct() async {
    final response = await productRepository.getProduct('["\$all"]', 10, currentPage);
    currentPage++;
    return response;
  }
}