import 'package:flutter/material.dart';

class ScaleTap extends StatefulWidget {
  const ScaleTap({super.key, required this.child, this.scale = 0.9, this.onTap});
  final Widget child;
  final double scale;
  final Function? onTap;

  @override
  State<ScaleTap> createState() => _ScaleTapState();
}

class _ScaleTapState extends State<ScaleTap> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        widget.onTap!();
        _controller.forward().then((value) {
          Future.delayed(const Duration(milliseconds: 100), () {
            _controller.reverse();
          });
        });
      },
      onTapDown: (_) {
        _controller.forward();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: widget.scale,
        ).animate(_controller),
        child: widget.child,
      ),
    );
  }
}
