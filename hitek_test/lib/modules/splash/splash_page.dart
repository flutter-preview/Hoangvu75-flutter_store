import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:hitek_test/widgets/app_logo.dart';



class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: MediaQuery.of(context).size.height / 2 - MediaQuery.of(context).viewPadding.top,
      end: 129.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animation.addListener(() => setState(() {}));

    Future.delayed(const Duration(milliseconds: 3000), () {
      _animationController.forward();
    }).then((value) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColor.TRANSPARENT,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: AppColor.TRANSPARENT,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: _animation.value,
            width: MediaQuery.of(context).size.width,
          ),
          const AppLogo(),
        ],
      ),
    );
  }
}
