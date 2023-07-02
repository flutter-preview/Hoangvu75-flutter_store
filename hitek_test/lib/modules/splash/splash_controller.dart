import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SplashController {
  late Stream<dynamic> splashControllerStream;

  late AnimationController _animationController;
  late Animation _animation;
  late BehaviorSubject<double> _animationState;

  double get animationValue => _animationState.value;

  SplashController({required TickerProvider provider, required BuildContext context}) {
    animationSetup(provider, context);

    splashControllerStream = Rx.combineLatestList<dynamic>([
      _animationState,
    ]);
  }

  void animationSetup(TickerProvider provider, BuildContext context) {
    double animationBeginValue = MediaQuery.of(context).size.height / 2 - MediaQuery.of(context).viewPadding.top;
    double animationEndValue = 129.0;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: provider,
    );

    _animationState = BehaviorSubject<double>.seeded(animationBeginValue);

    _animation = Tween<double>(
      begin: animationBeginValue,
      end: animationEndValue,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      _animationState.add(_animation.value);
    });

    Future.delayed(const Duration(milliseconds: 3000), () {
      _animationController.forward();
    }).then((value) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    });
  }

  void dispose() {
    _animationController.dispose();
  }
}