import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitek_test/common/config/app_constants.dart';

import '../common/theme/app_color.dart';


defaultAppBar() {
  return AppBar(
    backgroundColor: AppColor.TRANSPARENT,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: (MediaQuery.of(navigatorKey.currentContext!).platformBrightness == Brightness.dark)
          ? Brightness.light
          : Brightness.dark,
      statusBarColor: AppColor.TRANSPARENT,
    ),
  );
}