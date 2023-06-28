import 'package:flutter/material.dart';
import 'package:hitek_test/widgets/scale_tap.dart';
import 'package:rxdart/rxdart.dart';

class AnimatedIconButton extends StatefulWidget {
  const AnimatedIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.label,
    this.labelStyle,
    required this.isSelected,
  });

  final Icon icon;
  final Function onTap;
  final String label;
  final TextStyle? labelStyle;
  final BehaviorSubject<bool> isSelected;

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  late Widget? _textLabel;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 100,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animation.addListener(() => setState(() {}));

    widget.isSelected.listen((value) {
      if (value) {
        _textLabel = Text(
          widget.label,
          style: widget.labelStyle,
        );
        _animationController.forward();
      } else {
        _animationController.reverse().then((value) {
          setState(() {
            _textLabel = null;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: () {
        widget.onTap();
      },
      scale: 0.7,
      child: StreamBuilder<bool>(
        stream: widget.isSelected.stream,
        builder: (context, snapshot) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.ease,
            clipBehavior: Clip.none,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.icon,
                const SizedBox(width: 5),
                AnimatedOpacity(
                  opacity: widget.isSelected.value ? 1 : 0,
                  duration: const Duration(milliseconds: 1000),
                  child: AnimatedOpacity(
                    opacity: widget.isSelected.value ? 1 : 0,
                    duration: const Duration(milliseconds: 500),
                    child: Transform(
                      transform: Matrix4.translationValues(0, _animation.value, 0),
                      child: _textLabel,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
