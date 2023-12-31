import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitek_test/common/network/network_config.dart';

import '../../common/theme/app_color.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => BaseStatePage();
}

class BaseStatePage<T extends BasePage> extends State<T> with AutomaticKeepAliveClientMixin<T> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    NetworkConfig.networkConfig = NetworkConfig(context);
    NetworkConfig.networkConfig.handleNativeMethodCall(context);
  }

  static const systemUIOverlayDark = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarColor: AppColor.DEFAULT_BLACK,
  );

  static const systemUIOverlayLight = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: AppColor.DEFAULT_WHITE,
  );

  bool isDarkMode() {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  AppBar baseAppBar() {
    return AppBar(
      systemOverlayStyle: isDarkMode() ? systemUIOverlayDark : systemUIOverlayLight,
      toolbarHeight: 0,
    );
  }
}
