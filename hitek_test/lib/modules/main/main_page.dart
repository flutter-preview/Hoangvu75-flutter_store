import 'package:flutter/material.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:hitek_test/modules/base/base_page.dart';
import 'package:hitek_test/widgets/animated_icon_button.dart';
import 'package:hitek_test/widgets/default_app_bar.dart';
import 'package:rxdart/rxdart.dart';

class MainPage extends BasePage {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseStatePage<MainPage> {
  int pageIndex = 0;

  BehaviorSubject<bool> isSelected_0 = BehaviorSubject<bool>.seeded(true);
  BehaviorSubject<bool> isSelected_1 = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<bool> isSelected_2 = BehaviorSubject<bool>.seeded(false);

  final pages = [
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBar(),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 17
      ),
      decoration: BoxDecoration(
        color: (MediaQuery.of(context).platformBrightness == Brightness.dark)
            ? AppColor.DEFAULT_WHITE
            : AppColor.DEFAULT_BLACK,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AnimatedIconButton(
            icon: Icon(
              Icons.storefront_outlined,
              size: 35,
              color: isDarkMode() ? AppColor.DEFAULT_BLACK : AppColor.DEFAULT_WHITE,
            ),
            onTap: () {
              handleSelected(0);
            },
            label: "Store",
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDarkMode() ? AppColor.DEFAULT_BLACK : AppColor.DEFAULT_WHITE
            ),
            isSelected: isSelected_0,
          ),
          AnimatedIconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 35,
              color: isDarkMode() ? AppColor.DEFAULT_BLACK : AppColor.DEFAULT_WHITE,
            ),
            onTap: () {
              handleSelected(1);
            },
            label: "My cart",
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDarkMode() ? AppColor.DEFAULT_BLACK : AppColor.DEFAULT_WHITE,
            ),
            isSelected: isSelected_1,
          ),
          AnimatedIconButton(
            icon: Icon(
              Icons.person_outline,
              size: 35,
              color: isDarkMode() ? AppColor.DEFAULT_BLACK : AppColor.DEFAULT_WHITE,
            ),
            onTap: () {
              handleSelected(2);
            },
            label: "Account",
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDarkMode() ? AppColor.DEFAULT_BLACK : AppColor.DEFAULT_WHITE,
            ),
            isSelected: isSelected_2,
          ),
        ],
      ),
    );
  }

  void handleSelected(int position) {
    isSelected_0.add((position == 0) ? true : false);
    isSelected_1.add((position == 1) ? true : false);
    isSelected_2.add((position == 2) ? true : false);
  }
}
