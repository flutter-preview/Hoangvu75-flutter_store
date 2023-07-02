import 'package:flutter/material.dart';
import 'package:hitek_test/widgets/scale_tap.dart';
import 'package:rxdart/rxdart.dart';

import '../common/theme/app_color.dart';

class AnimatedIconButton extends StatefulWidget {
  const AnimatedIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
    required this.label,
    required this.isSelected,
  });

  final IconData iconData;
  final Function onTap;
  final String label;
  final BehaviorSubject<bool> isSelected;

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late Widget? _textLabel;

  late Color tintColor;

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
    )..addListener(() => setState(() {}));

    widget.isSelected.listen((value) {
      if (value) {
        _textLabel = Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: tintColor,
            overflow: TextOverflow.fade,
          ),
          maxLines: 1,
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

    _textLabel = const Text("");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tintColor = (MediaQuery.of(context).platformBrightness == Brightness.dark) ? AppColor.DEFAULT_WHITE : AppColor.DEFAULT_BLACK;
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  widget.iconData,
                  size: 30,
                  color: tintColor,
                ),
                const SizedBox(width: 5),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: widget.isSelected.value ? 70 : 0,
                  child: AnimatedOpacity(
                    opacity: widget.isSelected.value ? 1 : 0,
                    duration: const Duration(milliseconds: 1000),
                    child: Transform(
                      transform: Matrix4.translationValues(0, _animation.value, 0),
                      child: _textLabel,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
