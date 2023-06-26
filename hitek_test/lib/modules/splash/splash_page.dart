import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/image_path.dart';

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

    Timer(
      const Duration(seconds: 4),
      () {
        Navigator.pushReplacementNamed(context, '/login');
      },
    );
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: _animation.value,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: _appLogo(),
          )
        ],
      ),
    );
  }

  Image _appLogo() {
    return Image.asset(
      ImagePaths.app_logo,
      width: 156.0,
      height: 64.0,
    );
  }
}
