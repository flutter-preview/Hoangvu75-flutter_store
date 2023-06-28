import 'package:flutter/material.dart';
import 'package:hitek_test/common/network/network_config.dart';

import '../../common/config/app_constants.dart';

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
  void dispose() {
    super.dispose();
    NetworkConfig.networkConfig.dispose();
  }

  bool isDarkMode() {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }
}
