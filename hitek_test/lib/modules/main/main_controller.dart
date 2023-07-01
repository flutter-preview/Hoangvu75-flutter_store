import 'package:flutter/material.dart';
import 'package:hitek_test/modules/cart/cart_page.dart';
import 'package:hitek_test/modules/store/store_page.dart';
import 'package:rxdart/rxdart.dart';

class MainController {
  late BehaviorSubject<bool> isSelected_0;
  late BehaviorSubject<bool> isSelected_1;
  late BehaviorSubject<bool> isSelected_2;

  late PageController pageController;
  late List<Widget> pages;

  MainController() {
    isSelected_0 = BehaviorSubject<bool>.seeded(true);
    isSelected_1 = BehaviorSubject<bool>.seeded(false);
    isSelected_2 = BehaviorSubject<bool>.seeded(false);

    pageController = PageController();
    pages = [
      const StorePage(),
      const CartPage(),
      Container(
        color: Colors.greenAccent,
      ),
    ];
  }

  void onNavigate(int position) {
    isSelected_0.add((position == 0) ? true : false);
    isSelected_1.add((position == 1) ? true : false);
    isSelected_2.add((position == 2) ? true : false);
    pageController.animateToPage(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
