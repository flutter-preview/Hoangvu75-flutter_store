import 'package:flutter/material.dart';
import 'package:hitek_test/common/network/network_config.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => BaseStatePage();
}

class BaseStatePage<T extends BasePage> extends State<T> with AutomaticKeepAliveClientMixin<T> {
  late NetworkConfig networkConfig;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    networkConfig = NetworkConfig(context);
    networkConfig.handleNativeMethodCall(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
