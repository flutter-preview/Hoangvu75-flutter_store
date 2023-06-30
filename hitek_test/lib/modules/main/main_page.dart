import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:hitek_test/modules/base/base_page.dart';
import 'package:hitek_test/modules/main/main_controller.dart';
import 'package:hitek_test/widgets/animated_icon_button.dart';
import 'package:rxdart/rxdart.dart';

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
          appBar: baseAppBar(),
          extendBody: true,
          // body: mainController.pages[mainController.pageIndex.value],
          body: IndexedStack(
            index: mainController.pageIndex.value,
            children: mainController.pages,
          ),
          bottomNavigationBar: buildMyNavBar(context),
        );
      },
    );
  }

  TweenAnimationBuilder<double> buildMyNavBar(BuildContext context) {
    final Color navBarBackgroundColor = isDarkMode() ? AppColor.DEFAULT_BLACK : AppColor.DEFAULT_WHITE;
    final Color navBarBorderColor = isDarkMode() ? AppColor.DEFAULT_WHITE : AppColor.DEFAULT_BLACK;

    return TweenAnimationBuilder(
      tween: Tween<double>(
        begin: 100,
        end: 0,
      ),
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 1500),
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 17),
            decoration: BoxDecoration(
              color: navBarBackgroundColor.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                // top: BorderSide(
                //   : 2,
                //   color: navBarBorderColor,
                // )
                // color: navBarBorderColor,
                // width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                navBarButton(0, Icons.storefront_outlined, "Store", mainController.isSelected_0),
                navBarButton(1, Icons.shopping_cart_outlined, "My cart", mainController.isSelected_1),
                navBarButton(2, Icons.account_circle_outlined, "Account", mainController.isSelected_2),
              ],
            ),
          ),
        );
      },
    );
  }

  AnimatedIconButton navBarButton(
    int position,
    IconData iconData,
    String label,
    BehaviorSubject<bool> isSelected,
  ) {
    final Color navBarButtonColor = isDarkMode() ? AppColor.DEFAULT_WHITE : AppColor.DEFAULT_BLACK;
    final Color navBarTextColor = isDarkMode() ? AppColor.DEFAULT_WHITE : AppColor.DEFAULT_BLACK;

    return AnimatedIconButton(
      icon: Icon(
        iconData,
        size: 30,
        color: navBarButtonColor,
      ),
      onTap: () {
        mainController.onNavigate(position);
      },
      label: label,
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: navBarTextColor,
      ),
      isSelected: isSelected,
    );
  }
}
