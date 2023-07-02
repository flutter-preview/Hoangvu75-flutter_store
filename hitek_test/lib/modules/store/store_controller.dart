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

  late IProductRepository _productRepository;
  late int _currentPage;
  late BehaviorSubject<List<Product>> _bsListProduct;
  List<Product> get listProduct => _bsListProduct.value;

  late ScrollController scrollController;
  late BehaviorSubject<bool> _bsTitleState;
  bool get titleState => _bsTitleState.value;

  late AnimationController _animationController;
  late Animation _animation;
  late BehaviorSubject<double> _bsAnimationValue;
  double get animationValue => _bsAnimationValue.value;

  StoreController({required TickerProvider provider}) {
    setupProduct();
    setupAnimation(provider);
    setupScroll();

    storeControllerStream = Rx.combineLatestList<dynamic>([
      _bsListProduct,
      _bsTitleState,
      _bsAnimationValue,
    ]);
  }

  Future<void> onGetProduct() async {
    List<Product> mListProduct = await getProduct();
    List<Product> currentListProduct = _bsListProduct.value;
    currentListProduct.addAll(mListProduct);
    _bsListProduct.add(currentListProduct);
  }

  Future<List<Product>> getProduct() async {
    final response = await _productRepository.getProduct('["\$all"]', 10, _currentPage);
    _currentPage++;
    return response;
  }

  void setupProduct() {
    _currentPage = 1;
    _bsListProduct = BehaviorSubject<List<Product>>.seeded([]);
    _productRepository = ProductRepository(api: BaseService());
  }

  void setupAnimation(TickerProvider provider) {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: provider,
    );

    _bsAnimationValue = BehaviorSubject<double>.seeded(50);

    _animation = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      _bsAnimationValue.add(_animation.value);
    });
  }

  void setupScroll() {
    _bsTitleState = BehaviorSubject<bool>.seeded(false);

    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset > 75) {
        _animationController.forward();
        _bsTitleState.add(true);
      } else {
        _animationController.reset();
        _bsTitleState.add(false);
      }

      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          onGetProduct();
        }
      }
    });
  }

  Future<void> onRefreshProductList() async {
    _bsListProduct.add([]);
    _currentPage = 1;
    onGetProduct();
    await Future.delayed(const Duration(seconds: 1));
  }

  void dispose() {
    _animationController.dispose();
  }
}
