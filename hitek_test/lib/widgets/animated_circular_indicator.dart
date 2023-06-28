import 'package:flutter/material.dart';

class AnimatedColorCircularIndicator extends StatefulWidget {
  const AnimatedColorCircularIndicator({
    super.key,
    required this.beginColor,
    required this.endColor,
    this.width = 50,
    this.height = 50,
    this.strokeWidth = 5,
    this.animationDuration = const Duration(milliseconds: 1000),
  });

  final Color beginColor;
  final Color endColor;
  final double? width;
  final double? height;
  final double? strokeWidth;
  final Duration? animationDuration;

  @override
  State<AnimatedColorCircularIndicator> createState() => _AnimatedColorCircularIndicatorState();
}

class _AnimatedColorCircularIndicatorState extends State<AnimatedColorCircularIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animationController.addListener(() {
      if(_animationController.status == AnimationStatus.completed) {
        _animationController.reverse().then((value) => _animationController.forward());
      }
    });

    _colorTween = ColorTween(begin: widget.beginColor, end: widget.endColor).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _colorTween.addListener(() => setState(() {}));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CircularProgressIndicator(
        color: _colorTween.value,
        strokeWidth: widget.strokeWidth!,
      ),
    );
  }
}
