import 'package:flutter/material.dart';
import 'package:hitek_test/modules/cart/cart_controller.dart';
import 'package:hitek_test/modules/cart/cart_page.dart';
import 'package:hitek_test/modules/store/store_controller.dart';
import 'package:hitek_test/modules/store/store_page.dart';
import 'package:rxdart/rxdart.dart';

class MainController {
  static late BehaviorSubject<bool> isSelected_0;
  static late BehaviorSubject<bool> isSelected_1;
  static late BehaviorSubject<bool> isSelected_2;

  static late PageController pageController;
  late List<Widget> pages;

  MainController({required TickerProvider provider}) {
    isSelected_0 = BehaviorSubject<bool>.seeded(true);
    isSelected_1 = BehaviorSubject<bool>.seeded(false);
    isSelected_2 = BehaviorSubject<bool>.seeded(false);

    pageController = PageController();

    StoreController storeController = StoreController(provider: provider);
    CartController cartController = CartController(provider: provider);

    pages = [
      StorePage(controller: storeController),
      CartPage(
        controller: cartController,
      ),
      Container(
        color: Colors.greenAccent,
      ),
    ];
  }

  static void onNavigate(int position) {
    changeButtonPos(position);
    pageController.animateToPage(
      position,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  static void changeButtonPos(int position) {
    isSelected_0.add((position == 0) ? true : false);
    isSelected_1.add((position == 1) ? true : false);
    isSelected_2.add((position == 2) ? true : false);
  }

  void dispose() {
    pageController.dispose();
  }
}
