import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/models/product.dart';

class CartController {
  late Stream<dynamic> cartControllerStream;

  static late BehaviorSubject<List<Product>> _bsListProductInCart;
  static Stream<List<Product>> get listProductInCartStream => _bsListProductInCart.stream;
  static List<Product> get listProductInCart => _bsListProductInCart.value;

  late ScrollController scrollController;
  late BehaviorSubject<bool> _bsTitleState;
  bool get titleState => _bsTitleState.value;

  late AnimationController _animationController;
  late Animation _animation;
  late BehaviorSubject<double> _bsAnimationValue;
  double get animationValue => _bsAnimationValue.value;

  CartController({required TickerProvider provider}) {
    setupProduct();
    setupAnimation(provider);
    setupScroll();

    cartControllerStream = Rx.combineLatestList<dynamic>([
      _bsListProductInCart,
    ]);
  }

  static void addProduct(Product product) {
    List<Product> currentListProductInCart = listProductInCart;
    currentListProductInCart.add(product);
    _bsListProductInCart.add(currentListProductInCart);
  }

  static void removeProduct(Product product) {
    List<Product> currentListProductInCart = listProductInCart;
    currentListProductInCart.remove(product);
    _bsListProductInCart.add(currentListProductInCart);
  }

  static void removeAllProduct() {
    _bsListProductInCart.add([]);
  }

  void setupProduct() {
    _bsListProductInCart = BehaviorSubject<List<Product>>.seeded([]);
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
    });
  }

  void dispose() {
    _animationController.dispose();
  }
}