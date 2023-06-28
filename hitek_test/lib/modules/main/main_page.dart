import 'package:flutter/material.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:hitek_test/modules/base/base_page.dart';
import 'package:hitek_test/modules/main/main_controller.dart';
import 'package:hitek_test/widgets/animated_icon_button.dart';

class MainPage extends BasePage {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseStatePage<MainPage> {
  late MainController mainController;

  @override
  void initState() {
    super.initState();
    mainController = MainController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<int>(
      stream: mainController.pageIndex.stream,
      builder: (context, snapshot) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: mainController.pages[mainController.pageIndex.value],
          bottomNavigationBar: buildMyNavBar(context),
        );
      }
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 17
      ),
      decoration: BoxDecoration(
        color: isDarkMode()
            ? AppColor.DEFAULT_BLACK
            : AppColor.DEFAULT_WHITE,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(
          color: isDarkMode() ? AppColor.DEFAULT_WHITE : AppColor.DEFAULT_BLACK,
          width: 5,
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AnimatedIconButton(
            icon: Icon(
              Icons.storefront_outlined,
              size: 35,
              color: isDarkMode() ? AppColor.DEFAULT_WHITE : AppColor.DEFAULT_BLACK,
            ),
            onTap: () {
              mainController.onNavigate(0);
            },
            label: "Store",
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDarkMode() ? AppColor.DEFAULT_WHITE : AppColor.DEFAULT_BLACK
            ),
            isSelected: mainController.isSelected_0,
          ),
          AnimatedIconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 35,
              color: isDarkMode() ? AppColor.DEFAULT_WHITE : AppColor.DEFAULT_BLACK,
            ),
            onTap: () {
              mainController.onNavigate(1);
            },
            label: "My cart",
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDarkMode() ? AppColor.DEFAULT_WHITE : AppColor.DEFAULT_BLACK,
            ),
            isSelected: mainController.isSelected_1,
          ),
          AnimatedIconButton(
            icon: Icon(
              Icons.person_outline,
              size: 35,
              color: isDarkMode() ? AppColor.DEFAULT_WHITE : AppColor.DEFAULT_BLACK,
            ),
            onTap: () {
              mainController.onNavigate(2);
            },
            label: "Account",
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDarkMode() ? AppColor.DEFAULT_WHITE : AppColor.DEFAULT_BLACK,
            ),
            isSelected: mainController.isSelected_2,
          ),
        ],
      ),
    );
  }
}
