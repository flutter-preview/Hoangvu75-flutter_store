import 'package:flutter/material.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:rxdart/rxdart.dart';

class AnimatedLoadingLabel extends StatefulWidget {
  const AnimatedLoadingLabel({super.key});

  @override
  State<AnimatedLoadingLabel> createState() => _AnimatedLoadingLabelState();
}

class _AnimatedLoadingLabelState extends State<AnimatedLoadingLabel> with TickerProviderStateMixin {
  late _LoadingLabelAnimationObject _animationObject_1;
  late _LoadingLabelAnimationObject _animationObject_2;
  late _LoadingLabelAnimationObject _animationObject_3;

  @override
  void initState() {
    super.initState();
    _animationObject_1 = _LoadingLabelAnimationObject(
      provider: this,
      delay: const Duration(milliseconds: 0),
    );
    _animationObject_2 = _LoadingLabelAnimationObject(
      provider: this,
      delay: const Duration(milliseconds: 300),
    );
    _animationObject_3 = _LoadingLabelAnimationObject(
      provider: this,
      delay: const Duration(milliseconds: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLoadingObject(_animationObject_1),
        const SizedBox(width: 15),
        _buildLoadingObject(_animationObject_2),
        const SizedBox(width: 15),
        _buildLoadingObject(_animationObject_3),
      ],
    );
  }

  StreamBuilder<double> _buildLoadingObject(_LoadingLabelAnimationObject animationObject) {
    return StreamBuilder<double>(
      stream: animationObject.animationStream,
      builder: (context, snapshot) {
        return Transform.translate(
          offset: Offset(0, animationObject.animationValue),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: AppColor.APP_BAR_START,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}

class _LoadingLabelAnimationObject {
  late AnimationController _animationController;
  late Animation _animation;
  late BehaviorSubject<double> _animationState;

  Stream<double> get animationStream => _animationState.stream;

  double get animationValue => _animationState.value;

  _LoadingLabelAnimationObject({required TickerProvider provider, required Duration delay}) {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: provider,
    );

    _animationState = BehaviorSubject<double>.seeded(10);

    _animation = Tween<double>(begin: 10, end: -10)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.ease))
      ..addListener(() => _animationState.add(_animation.value));

    _startAnimation(delay);
  }

  _startAnimation(Duration delay) async {
    await Future.delayed(delay);
    _animationController.repeat(reverse: true);
  }
}
