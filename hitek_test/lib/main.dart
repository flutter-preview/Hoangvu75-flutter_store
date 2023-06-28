import 'package:flutter/material.dart';
import 'package:hitek_test/common/config/app_constants.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:hitek_test/modules/login/login_page.dart';
import 'package:hitek_test/modules/main/main_page.dart';
import 'package:hitek_test/modules/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColor.DEFAULT_BLUE
      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(useMaterial3: true),
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}
