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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setStatusBarTheme();
  }

  @override
  void dispose() {
    super.dispose();
    NetworkConfig.networkConfig.dispose();
  }

  static const systemUIOverlayDark = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarColor: AppColor.TRANSPARENT,
  );

  static const systemUIOverlayLight = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: AppColor.TRANSPARENT,
  );

  void _setStatusBarTheme() {
    if (isDarkMode()) {
      SystemChrome.setSystemUIOverlayStyle(systemUIOverlayDark);
    } else {
      SystemChrome.setSystemUIOverlayStyle(systemUIOverlayLight);
    }
  }

  bool isDarkMode() {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }
}
