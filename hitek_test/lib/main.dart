import 'package:flutter/material.dart';
import 'package:hitek_test/common/theme/app_theme.dart';
import 'package:hitek_test/modules/login/login_page.dart';
import 'package:hitek_test/modules/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeMode>(
      stream: appTheme.themeStream,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          themeMode: appTheme.themeMode,
          darkTheme: ThemeData.dark(useMaterial3: true),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashPage(),
            '/login': (context) => LoginPage(),
          },
        );
      },
    );
  }
}
